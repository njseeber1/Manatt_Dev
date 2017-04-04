<%@ WebHandler Language="C#" Class="PDFHandler" %>

using System;
using System.Web;
using System.Data;
using System.Linq;
using System.Xml.Linq;
using CMS.DataEngine;
using SelectPdf;
public class PDFHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        var documentId = 0;
        var nodeId = 0;
        var printOptions = context.Request.QueryString["options"].ToLower().Split(',');
        //print-profile-picture,print-profile,print-publications,print-speaking,print-honors,print-memberships,print-experience,print-events,print-news,print-awards,print-inthenews,lang-portuguese
        //"Stats,Picture,Profile,Publications,speaking,Awards,Memberships,Experience,Events,News,Ranking,News"
        int.TryParse(context.Request.QueryString["id"], out documentId);
        int.TryParse(context.Request.QueryString["nodeid"], out nodeId);
        byte[] response;

        var dsPeople = new DataQuery("Manatt.People.PeopleProfilePDFQuery")
                .Where("WHERE VPS.DocumentID", QueryOperator.Equals, documentId)
                .Result
                ;

        var dsRelatedIndustries = new DataQuery("Manatt.People.RelatedIndustriesQuery")
            .Where("WHERE VPS.DocumentID", QueryOperator.Equals, documentId)
            .Result
            ;

        var dsRelatedServices = new DataQuery("Manatt.People.RelatedServicesQuery")
        .Where("WHERE VPS.DocumentID", QueryOperator.Equals, documentId)
        .Result
        ;

        var dsInTheNews = new DataQuery("Manatt.People.InTheNewsQuery")
        .Where("WHERE VP.NodeID", QueryOperator.Equals, nodeId)
        .Result
        ;

        string html = "";
        string relatedIndustriesHtml = "";
        string inTheNewsHtml = "";
        string relatedServicesHtml = "";
        string filename = "";
        string baseUrl = context.Request.Url.GetLeftPart(UriPartial.Authority);

        foreach (DataTable tbl in dsRelatedServices.Tables)
            foreach (DataRow dr in tbl.Rows)
                relatedServicesHtml += "<li> <a href='" + baseUrl + ConvertToString(dr["RelatedServicePath"]) + "'>" + ConvertToString(dr["RelatedService"]) + "</a> </li>";

        foreach (DataTable tbl in dsRelatedIndustries.Tables)
            foreach (DataRow dr in tbl.Rows)
                relatedIndustriesHtml += "<li> <a href='" + baseUrl + ConvertToString(dr["RelatedIndustryPath"]) + "'>" + ConvertToString(dr["RelatedIndustry"]) + "</a> </li>";

        foreach (DataTable tbl in dsInTheNews.Tables)
        {
            foreach (DataRow dr in tbl.Rows)
            {
                var title = ConvertToString(dr["Title"]);
                title = title.Length > 70 ? title.Substring(0, 69) + "..." : title;
                var content = StripTagsRegex(ConvertToString(dr["Content"]));
                content = content.Length > 150 ? content.Substring(0, 149) + ".." : content;

                inTheNewsHtml += "<li class='post col-md-6 col-sm-6 col-xs-12'> <p class='date'>" + Convert.ToDateTime(ConvertToString(dr["Date"])).ToString("MM.dd.yy") + "</p><h4 class='blue-lt'> <a href='" + baseUrl + ConvertToString(dr["NodeAliasPath"]) + "'> " + title + " </a> </h4> <p class='snippet'> " + content + " </p></li>";
            }
        }

        foreach (DataTable tbl in dsPeople.Tables)
        {
            foreach (DataRow dr in tbl.Rows)
            {
                filename = ConvertToString(dr["FullName"]) + ".pdf";
                string profile = ConvertToString(dr["ProfesionalExperience"]);
                string email = ConvertToString(dr["Email"]);
                string education = ConvertToString(dr["Education"]);
                string publications = ConvertToString(dr["Publications"]);
                string speaking = ConvertToString(dr["SpeakingEngagements"]);
                string primaryPractice = ConvertToString(dr["PrimaryPractice"]);
                string awards = ConvertToString(dr["HonorsAndAwards"]);
                string memberships = ConvertToString(dr["MembershipActivities"]);
                string experience = ConvertToString(dr["RepersentativeMatters"]);
                string individualAwards = ConvertToString(dr["IndividualAwardsText"]);
                string bioText = ConvertToString(dr["BioLogoText"]);
                string spanishProfile = ConvertToString(dr["Spanish_ProfessionalExperience"]);
                string spanishMembership = ConvertToString(dr["Spanish_MembershipActivities"]);
                string spanishEducation = ConvertToString(dr["Spanish_Education"]);
                string spanishPrimarytitle = ConvertToString(dr["Spanish_Title"]);
                string portugueseProfile = ConvertToString(dr["Portugese_ProfessionalExperience"]);
                string portugueseMembership = ConvertToString(dr["Portugese_MembershipActivities"]);
                string portugueseEducation = ConvertToString(dr["Portugese_Education"]);
                string portuguesePrimarytitle = ConvertToString(dr["Portugese_Title"]);

                if (printOptions.Contains("lang-portuguese"))
                {
                    profile = string.IsNullOrEmpty(portugueseProfile) ? profile : portugueseProfile;
                    memberships = string.IsNullOrEmpty(portugueseMembership) ? memberships : portugueseMembership;
                    education = string.IsNullOrEmpty(portugueseEducation) ? education : portugueseEducation;
                    primaryPractice = string.IsNullOrEmpty(portuguesePrimarytitle) ? primaryPractice : portuguesePrimarytitle;
                }
                else if (printOptions.Contains("lang-spanish"))
                {
                    profile = string.IsNullOrEmpty(spanishProfile) ? profile : spanishProfile;
                    memberships = string.IsNullOrEmpty(spanishMembership) ? memberships : spanishMembership;
                    education = string.IsNullOrEmpty(spanishEducation) ? education : spanishEducation;
                    primaryPractice = string.IsNullOrEmpty(spanishPrimarytitle) ? primaryPractice : spanishPrimarytitle;
                }


                html = "<!DOCTYPE html>" +
                        "<html>" +
                        "   <head>" +
                        "      <title>Manatt, Phelps &amp; Phillips, LLP - " + ConvertToString(dr["FullName"]) + " </title>" +
                        "      <meta charset='UTF-8' />" +
                        "      <link href='" + baseUrl + "/cmspages/pdf-profile.css' rel='stylesheet' />" +
                        //"      <link href='http://manattcms.thinklogic.net/CMSPages/GetResource.ashx?stylesheetfile=/App_Themes/Custom/Fonts.css&combiner=styles' rel='stylesheet' type='text/css' />
                        //"      <script type='text/javascript' src='http://fast.fonts.net/jsapi/a2f2325c-9bbe-4e0d-adcd-6236550cbc77.js'></script>
                        "   </head>" +
                        "   <body class='LTR Safari Chrome Safari12 Chrome12 ENUS ContentBody'>" +
                        "   <section id='more' class='full'>" +
                        "   <table width='100%' border='0' style='z-index:999'>" +
                        "      <tr>" +
                        "        <td rowspan='2' bgcolor='#F8F2e6'><h1 class='yellow' style='margin-bottom:0'>" + ConvertToString(dr["FullName"]) + "</h1></td>" +
                        "        <td bgcolor='#F8F2e6'><img src='" + baseUrl + "/Manatt/media/Media/Images/manatt-yellow.jpg' alt='Mannatt'></td>" +
                        "      </tr>" +
                        "      <tr>" +
                        "        <td bgcolor='#F8F2e6'><img src='" + baseUrl + ConvertToString(dr["PhotoPath"]).TrimStart("~".ToCharArray()) + "' class='profile-img' width='220' /></td>" +
                        "      </tr>" +
                        "      <tr>" +
                        "        <td colspan='2'>&nbsp;</td>" +
                        "      </tr>" +
                        "      <tr>" +
                        "        <td><div class='col-md-12 active' id='profile'>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Professional Experience</h1>" + profile + "</div>" +
                        "         </div></td>" +
                        "        <td rowspan='12' style='vertical-align: top;' class='infobox'>" +
                        "            <h5 class='partner sub-title sans' >" + ConvertToString(dr["PrimaryPracticeTitle"]) + "</h5>" +
                        "            <h5 class='sub-partner sans sub-title'><a class='sub-title' href='" + baseUrl + ConvertToString(dr["PrimaryPracticePath"]) + "'>" + primaryPractice + "</a></h5>" +
                        "            <p><strong>T</strong> " + ConvertToString(dr["Office1Phone"]) + "</p>" +                        
                        "            <p><strong>E</strong> <a href='mailto:" + email + "'>" + email + "</a></p>" +
                        "        </td>" +
                        "      </tr>" +
                        "      <tr>" +
                        "        <td><div class='c-text col-md-12 active' id=''>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Education</h1>" +
                        "               <div class='nonbreaking'>" + education + "</div>" +
                        "            </div>" +
                        "         </div>  </td>" +
                        "      </tr>" +
                        "      <tr class='" + (ConvertToString(dr["BarAdmissions"]) == "" ? "hide" : "") + "' >" +
                        "        <td><div class='c-text col-md-12 active' id=''>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Bar Admissions</h1>" +
                        "               <ul>" +
                        "                  <li>" + ConvertToString(dr["BarAdmissions"]) + "</li>" +
                        "               </ul>" +
                        "           </div>" +
                        "        </div>  </td>" +
                        "      </tr>" +
                        "      <tr>" +
                        "        <td><div class='c-text col-md-12 active' id='membership'>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Memberships</h1>" +
                        "               " + memberships +
                        "            </div>" +
                        "        </div></td>" +
                        "      </tr>" +
                        "      <tr class='" + (ConvertToString(dr["LanguagesSpoken"]) == "" ? "hide" : "") + "'>" +
                        "        <td><div class='c-text col-md-12 active' id=''>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Languages</h1>" +
                        "               <div class='nonbreaking brakes'>                  " +
                        "                  " + ConvertToString(dr["LanguagesSpoken"]) +
                        "               </div>" +
                        "            </div>" +
                        "         </div>  </td>" +
                        "      </tr>" +
                        "      <tr class='" + (awards == "" ? "hide" : "") + "'>" +
                        "        <td><div class='c-text col-md-12 active' id='honors'>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Honors &amp; Awards</h1>" +
                        "               " + awards +
                        "            </div>" +
                        "         </div></td>" +
                        "      </tr>" +
                        "      <tr class='" + (experience == "" ? "hide" : "") + "'>" +
                        "        <td><div class='c-text col-md-12 active' id='experience'>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Experience</h1>" +
                        "               " + experience +
                        "            </div>" +
                        "         </div></td>" +
                        "      </tr>" +
                        "      <tr class='" + (publications == "" ? "hide" : "") + "'>" +
                        "        <td><div class='c-text col-md-12 active' id='publications'>" +
                        "            <div>" +
                        "               <h1 class='sub-menu-header'>Publications</h1>" +
                        "               " + publications +
                        "            </div>" +
                        "         </div></td>" +
                        "      </tr>" +
                        //"      <tr>" +
                        //"        <td> <div class='c-text col-md-12 active' id=''>" +
                        //"            <div>" +
                        //"               <h1 class='sub-menu-header'>Services</h1>" +
                        //"               <ul>" +
                        //"                  <li>Capital Markets</li>
                        //"                  <li>Manatt Digital Media</li>
                        //"                  <li>Technology and Advertising</li>
                        //"                  <li>Mergers and Acquisitions</li>
                        //"               </ul>" +
                        //"            </div>" +
                        //"         </div> </td>" +
                        //"      </tr>" +
                        //"      <tr>" +
                        //"        <td><div class='c-text col-md-12 active' id=''>
                        //"            <div>
                        //"               <h1 class='sub-menu-header'>Industries</h1>
                        //"               <ul>
                        //"                  <li>Energy</li>
                        //"                  <li>Financial Services</li>
                        //"               </ul>
                        //"            </div>
                        //"         </div></td>
                        //"      </tr>                        
                        //"      <tr>
                        //"        <td><div class='c-text col-md-12 active' id='speaking'>
                        //"            <div>
                        //"               <h1 class='sub-menu-header'>Speaking Engagements</h1>
                        //"               <p>Panelist, &ldquo;The Social Justice Case for Paying College Athletes for Their Intellectual Property Rights,&rdquo; Defense Research Institute Annual Meeting, October 24, 2014.</p>
                        //"               <p>Panelist, &ldquo;The Avenues Of Sports Law: Breaking Into The Industry,&rdquo; Sports Law Societies of USC, UCLA and Loyola Law Schools, March 2012.</p>
                        //"               <p>Panelist, &ldquo;Celebrities And Brands: Image And Publicity Rights,&rdquo; INTA Annual Meeting, August 17, 2011.</p>
                        //"               <p>Panelist, &ldquo;Right of Publicity Law,&rdquo; INTA/ASIPI Conference, March 21 22, 2011.</p>
                        //"               <p>Featured speaker, &ldquo;Protecting the Celebrity: Right of Publicity and Beyond,&rdquo; CLE International Film, TV &amp; New Media Law Conference, January 28, 2011.</p>
                        //"               <p>Moderator, &ldquo;Use Of The Athlete&rsquo;s Image In Video Games,&rdquo; Santa Clara Law School Sports Law Symposium, September 17, 2010.</p>
                        //"               <p>Panelist, &ldquo;Right Of Publicity In Sports,&rdquo; ABA Annual Convention, August 7, 2010.</p>
                        //"               <p>Lecturer, &ldquo;Right of Publicity Law,&rdquo; CLE International Conference on Film and Television Law, December 2008, January 2010.</p>
                        //"               <p>Panelist, &ldquo;Current Trends in Online Games and Virtual Worlds,&rdquo; Law Seminars International Conference on Gamer Technology Law, March 2009.</p>
                        //"               <p>Lecturer, &ldquo;Trademark Law in the Entertainment Industry,&rdquo; ALI-ABA Entertainment, Arts and Sports Law Program, January 1997-2009.</p>
                        //"               <p>Panelist, &ldquo;Copyright Fair Use,&rdquo; University of San Francisco Law School Fair Use Symposium, November 2008.</p>
                        //"               <p>Panelist, &ldquo;Movies, Music &amp; Dead Celebrities,&rdquo; AIPLA Annual Meeting, October 2006.</p>
                        //"               <p> Panelist, Recent Copyright Legislation, &ldquo;Copyright After <em>MGM v. Grokster</em>,&rdquo; Glasser LegalWorks Seminar, July 14, 2005. </p>
                        //"               <p>Lecturer, &ldquo;Right of Publicity Law,&rdquo; J. Reuben Clark Law Society, May 2004.</p>
                        //"               <p>Panelist, &ldquo;Copyright Law,&rdquo; American Intellectual Property Law Association Annual Meeting, January 2004.</p>
                        //"               <p>Lecturer, &ldquo;Right of Publicity Law,&rdquo; N.Y. State Bar Entertainment/Arts and Sports Law Section Retreat, Spring 2003.</p>
                        //"               <p>Panelist, &ldquo;Internet Issues in the Entertainment Industry,&rdquo; ABA Section of Business Law Spring Meeting, 2003.</p>
                        //"               <p>Panelist, &ldquo;Right of Publicity and the First Amendment,&rdquo; California State Bar Intellectual Property Law Section Spring Meeting, 2003.</p>
                        //"               <p>Lecturer, &ldquo;Right of Publicity Law,&rdquo; Federalist Society Seminar on Intellectual Property and Free Speech, 2001.</p>
                        //"               <p>Panelist, &ldquo;Right of Publicity Law,&rdquo; Bar of San Francisco CLE Program, 1999.</p>
                        //"               <p> <strong>Representative Media Interviews/Reports</strong> </p>
                        //"               <p> &ldquo;Supreme Court Rulings Mark Shift in Patent, Copyright Law,&rdquo; and &ldquo;High Stakes Smokey Robinson Case Nears Settlement,&rdquo; <em>Los Angeles Daily Journal</em>, December 26, 2014. </p>
                        //"               <p> &ldquo;Supreme Court Declines to Review Superman Case,&rdquo; <em>Los Angeles Daily Journal</em>, October 7, 2014. </p>
                        //"               <p> &ldquo;Will Circuit Let Football Greats Sit Out The Big Game?&rdquo; <em>The Recorder</em>, July 6, 2012. </p>
                        //"               <p> <em>NPR Morning Edition</em>, &ldquo;John Steinbeck,&rdquo; June 15, 2006. </p>
                        //"               <p> &ldquo;Steinbeck Heirs Should Get Rights to His Book, Federal Judge Rules,&rdquo; <em>Los Angeles Times</em>, June 13, 2006. </p>
                        //"               <p> &ldquo;Star Power: Celebrity Rights,&rdquo; <em>The Boston Globe</em>, June 4, 2006. </p>
                        //"               <p> &ldquo;Steinbeck Heirs Entangled In Epic Family Lawsuit,&rdquo; <em>The New York Times</em>, August 2, 2004. </p>
                        //"               <p> &ldquo;Steinbeck Heirs Sue Widow&rsquo;s Estate,&rdquo; <em>Los Angeles Times</em>, July 16, 2004. </p>
                        //"               <p> &ldquo;John Steinbeck&rsquo;s Son Sees Conspiracy To Cheat Blood Heirs,&rdquo; <em>San Francisco Chronicle</em>, July 16, 2004. </p>
                        //"               <p> &ldquo;L.A. Jury Rules Frank Sinatra Trademark Infringed,&rdquo; <em>Yahoo! News</em>. </p>
                        //"               <p> &ldquo;Law Review Article Guides Missouri High Court In Ruling,&rdquo; <em>Daily Journal Extra</em>, p. 6, September 22, 2003. </p>
                        //"               <p> &ldquo;Tiger Woods and the Jireh Case,&rdquo; <em>Outside The Lines</em>, ESPN, July 14, 2002. </p>
                        //"               <p> &ldquo;Michael Eisner Testifies Before Congress Regarding Internet Piracy,&rdquo; <em>CNBC Capitol Report</em>, February 28, 2002. </p>
                        //"               <p> &ldquo;Movie Star Loses Case On First Amendment Rights,&rdquo; <em>Corporate Legal Times</em>, September 2001. </p>
                        //"               <p> &ldquo;Ruling Strikes Blow to Rights of Celebrities,&rdquo; <em>Los Angeles Daily Journal</em>, July 9, 2001. </p>
                        //"               <p> &ldquo;Actor Dustin Hoffman Loses Damages Award On Appeal,&rdquo; <em>San Francisco Chronicle</em>, July 7, 2001. </p>
                        //"               <p> &ldquo;Use Of Altered Celebrity Photo OK, Court Says,&rdquo; <em>Los Angeles Times</em>, July 7, 2001. </p>
                        //"               <p> &ldquo;Famous Retain Wealth of Images,&rdquo; <em>San Francisco Chronicle</em>, May 1, 2001. </p>
                        //"               <p> &ldquo;This Case Is Going To The Dogs,&rdquo; <em>The Recorder</em>, May 22, 2000. </p>
                        //"               <p> &ldquo;This Legal Dog Fight Is No Joke,&rdquo; <em>Los Angeles Times</em>, May 2, 2000. </p>
                        //"               <p> &ldquo;Age Of The Internet: Domain Names For Celebrities,&rdquo; <em>CNN Digital Jam</em>, October 27, 1999. </p>
                        //"               <p> &ldquo;Heirs Hail Bill Protecting Use Of Celebrity Images,&rdquo; <em>The Business Press</em>, September 6, 1999. </p>
                        //"               <p> &ldquo;Interview On California&rsquo;s Amended Posthumous Right of Publicity Statute,&rdquo; <em>CPCC 89.3 FM</em>, August 31, 1999. </p>
                        //"               <p> &ldquo;Running With The Rat Pack,&rdquo; <em>Los Angeles Times</em>, August 18, 1999. </p>
                        //"               <p> &ldquo;Star Signs: With Faces Worth Millions Celebrities Are Seeking New Ways to Protect Their Turf,&rdquo; <em>ABA Journal</em>, June 1999. </p>
                        //"               <p> &ldquo;The Battle Over Tiger Woods,&rdquo; <em>ABC World News Saturday</em>, February 20, 1999. </p>
                        //"               <p> &ldquo;Court Rules Against Use of &lsquo;Elvis&rsquo; Moniker,&rdquo; <em>Daily Variety</em>, May 11, 1998. </p>
                        //"               <p> &ldquo;Woods Wins Lawsuit Against Franklin Mint,&rdquo; <em>Milwaukee General Sentinel</em>, April 16, 1998. </p>
                        //"               <p> &ldquo;Why, Soitenly!: Firm Sees Market in Three Stooges,&rdquo; <em>Los Angeles Times</em>, December 19, 1996. </p>
                        //"               <p> &ldquo;Vigilant Copyright Holders Patrol The Internet,&rdquo; <em>The Wall Street Journal</em>, December 13, 1995. </p>
                        //"               <p> &ldquo;Hunka Cyber-love: Elvis Estate Guards Rights On Web Page,&rdquo; <em>The Commercial Appeal (Memphis)</em>, July 9, 1995. </p>
                        //"               <p> &ldquo;Elvis Presley Enterprises Successful in CD-ROM Lawsuit,&rdquo; <em>Business Wire</em>, April 7, 1995. </p>
                        //"               <p> &ldquo;Heartbreak Hotel In The Internet-Elvis Board Game,&rdquo; <em>Chicago Tribune</em>, November 27, 1994. </p>
                        //"            </div>
                        //"         </div></td>
                        //"      </tr>


                //"      <tr>
                //"        <td>&nbsp;</td>
                //"      </tr>
                //"      <tr>
                //"        <td>&nbsp;</td>
                //"      </tr>
                "    </table>" +
                        "   </section>" +
                        "   </body>" +
                        "</html>";

                //html = "<!DOCTYPE html>" +
                //              "  <html>" +
                //              "     <head>" +
                //              "        <title>Manatt, Phelps &amp; Phillips, LLP - " + ConvertToString(dr["FullName"]) + " </title>" +
                //              "        <meta charset='UTF-8' />" +
                //              "    <link href='" + baseUrl + "/cmspages/pdf-profile.css' rel='stylesheet' />" +
                //              //"<link href='http://manattcms.thinklogic.net/CMSPages/GetResource.ashx?stylesheetfile=/App_Themes/Custom/Fonts.css' rel='stylesheet' type='text/css' />" +
                //              //"<script type='text/javascript' src='http://fast.fonts.net/jsapi/a2f2325c-9bbe-4e0d-adcd-6236550cbc77.js'></script>" +
                //              "     </head>" +
                //              "     <body class='LTR Safari Chrome Safari12 Chrome12 ENUS ContentBody'>" +
                //              "        <section id='more' class='full'>" +
                //              "              <table width='100%' border='0'>" +
                //              "                 <tr>" +
                //              "                    <td colspan='4' align='left' valign='top'><img src='" + baseUrl + "/Manatt/media/Media/Images/manatt-yellow.jpg' alt='Mannatt'></td>" +
                //              "                 </tr>" +
                //              "                 <tr>" +
                //              "                    <td align='left' valign='top'>                     " +
                //              "                    </td>" +
                //              "                    <td align='left' valign='top'>" +
                //              "                       <h2 class='yellow'></h2>                    " +
                //              "                    </td>" +
                //              "                 </tr>" +
                //              "                 <tr>" +
                //              "     " + (printOptions.Contains("picture") ? "<td width='40%' rowspan='4' align='left' valign='top'><img src='" + baseUrl + ConvertToString(dr["PhotoPath"]).TrimStart("~".ToCharArray()) + "' width='320' /></td>" : "") +
                //              "                    <td width='60%' align='left' valign='top'>      " +
                //              "                       <h1 class='yellow'>" + ConvertToString(dr["FullName"]) + "</h1>" +
                //              "                       <h3 class='blue-lt title sans'>" + ConvertToString(dr["PrimaryPracticeTitle"]) + "</h3>                                                                                                                " +
                //              "                       <h2 class='sans sub-title'><a class='sub-title' href='" + baseUrl + ConvertToString(dr["PrimaryPracticePath"]) + "'>" + primaryPractice + "</a></h2>                            " +
                //              "                    </td>    " +
                //              "                 </tr> " +
                //              "                 <tr> " +
                //              "                    <td align='left' valign='top'> " +
                //              "                       <ul> " +
                //              "                          <li><strong>Email:</strong><a href='mailto:lgoldstein@manatt.com'>lgoldstein@manatt.com</a></li>" +
                //              "                          <li><strong>" + ConvertToString(dr["Office1Name"]) + "</strong>" + ConvertToString(dr["Office1Phone"]) + "</li>" +
                //              "                       </ul>" +
                //              "                    </td>" +
                //              "                    <td align='left' valign='top'>" +
                //              "                    </td>                  " +
                //              "                 </tr>               " +
                //              "              </table>" +
                //              "           <div class='c-text col-md-12 active" + (ConvertToString(dr["BarAdmissions"]) == "" ? " hide" : "") + "'>" +
                //              "              <div>" +
                //              "                 <h1 class='sub-menu-header'>Bar Admissions</h1>" +
                //              "                 <ul>" +
                //              "                    <li>" + ConvertToString(dr["BarAdmissions"]) + "</li>" +
                //              "                 </ul>" +
                //              "              </div>" +
                //              "           </div>  " +
                //              "           <div class='c-text col-md-12 active' id=''> " +
                //              "              <div> " +
                //              "                 <h1 class='sub-menu-header'>Education</h1> " +
                //              "                 <ul> " +
                //              "                    <li>" + education + "</li> " +
                //              "                 </ul> " +
                //              "              </div> " +
                //              "           </div>   " +
                //              "           <div class='c-text col-md-12 active" + (ConvertToString(dr["LanguagesSpoken"]) == "" ? " hide" : "") + "'>" +
                //              "              <div>" +
                //              "                 <h1 class='sub-menu-header'>Languages</h1>" +
                //              "                 <ul>" +
                //              "                    <li>" + ConvertToString(dr["LanguagesSpoken"]) + "</li>" +
                //              "                 </ul>" +
                //              "              </div>" +
                //              "           </div>   " +
                //              "           <div class='c-text col-md-12 active' id=''>" +
                //              "              <div>" +
                //              "                 <h1 class='sub-menu-header'>Services</h1>" +
                //              "                 <ul>" + relatedServicesHtml + "</ul>" +
                //              "              </div>" +
                //              "           </div>  " +
                //              "           <div class='c-text col-md-12 active' id=''>" +
                //              "              <div>" +
                //              "                 <h1 class='sub-menu-header'>Industries</h1>" +
                //              "                 <ul>" + relatedIndustriesHtml + "</ul>" +
                //              "              </div>" +
                //              "           </div>  " +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("profile") || string.IsNullOrEmpty(profile) ? "" : "active") + "' id='profile'> <div> <h1 class='sub-menu-header'>Profile</h1> " + profile + " </div></div>" +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("experience") || string.IsNullOrEmpty(experience) ? "" : "active") + "' id='experience'> <div> <h1 class='sub-menu-header'>Experience</h1> " + experience + " </div></div>" +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("speaking") || string.IsNullOrEmpty(speaking) ? "" : "active") + "' id='speaking'> <div> <h1 class='sub-menu-header'>Speaking Engagements</h1> " + speaking + " </div></div>" +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("awards") || string.IsNullOrEmpty(awards) ? "" : "active") + "' id='honors'> <div> <h1 class='sub-menu-header'>Honors &amp; Awards</h1> " + awards + " </div></div>" +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("memberships") || string.IsNullOrEmpty(memberships) ? "" : "active") + "' id='membership'> <div> <h1 class='sub-menu-header'>Membership</h1> " + memberships + " </div></div>" +
                //              "         <div class='c-text col-md-12 " + (!printOptions.Contains("publications") || string.IsNullOrEmpty(publications) ? "" : "active") + "' id='publications'> <div> <h1 class='sub-menu-header'>Publications</h1> " + publications + " </div></div>" +
                //              "        </section>" +
                //              "     </body>" +
                //              "  </html>";


                //html = @"<html>" +
                //       "<head>" +
                //       "    <title></title>" +
                //       "    <meta charset='UTF-8' />    " +
                //       "    <link href='" + baseUrl + "/cmspages/pdf-profile.css' rel='stylesheet' />" +
                //       "</head>" +
                //       "<body class='LTR Safari Chrome Safari12 Chrome12 ENUS ContentBody'>" +
                //       "<section id='more' class='full row'>" +
                //       "    <table width='100%' border='0'>                                                                                                                                                                                  " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "           <td colspan='3' align='left' valign='top'><img src='" + baseUrl + "/Manatt/media/Media/Images/manatt-yellow.jpg' alt='Mannatt'></td>                                                                      " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <h1 class='yellow'>" + ConvertToString(dr["FullName"]) + "</h1>                                                                                                                                        " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td colspan='2' align='left' valign='bottom'>                                                                                                                                                                " +
                //       "              <h4 class='blue-lt title sans'>" + ConvertToString(dr["PrimaryPracticeTitle"]) + "</h4>                                                                                                                " +
                //       "              <h5 class='sans sub-title'><a class='sub-title' href='" + baseUrl + ConvertToString(dr["PrimaryPracticePath"]) + "'>" + primaryPractice + "</a></h5>                            " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "     " + (printOptions.Contains("picture") ? "<td width='40%' rowspan='4' align='left' valign='top'><img src='" + baseUrl + ConvertToString(dr["PhotoPath"]).TrimStart("~".ToCharArray()) + "' width='320' /></td>" : "") +
                //       "           <td width='20%' align='left' valign='top'>                                                                                                                                                                " +
                //       "              <h5 class='sans'>Contact</h5>                                                                                                                                                                          " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td width='20%' align='left' valign='top'>&nbsp;</td>                                                                                                                                                     " +
                //       "           <td width='20%' align='left' valign='top'>                                                                                                                                                                " +
                //       "              <h5 class='sans'>Bar Admissions</h5>                                                                                                                                                                   " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul>                                                                                                                                                                                                   " +
                //       "                 <li><a href='" + ConvertToString(dr["Email"]) + "'>" + ConvertToString(dr["Email"]) + "</a></li>                                                                                                    " +
                //       "                 <li><p>Phone: " + ConvertToString(dr["Office1Phone"]) + "</p></li>                                                                                                                                  " +
                //       "              </ul>                                                                                                                                                                                                  " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul>                                                                                                                                                                                                   " +
                //       "                 <li class=' yellow'><a href='" + baseUrl + ConvertToString(dr["Office1Path"]) + "'>" + ConvertToString(dr["Office1Name"]) + "</a></li>                                                              " +
                //       "              </ul>                                                                                                                                                                                                  " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul>                                                                                                                                                                                                   " +
                //       "                 <li>" + ConvertToString(dr["BarAdmissions"]) + "</li>                                                                                                                                               " +
                //       "              </ul>                                                                                                                                                                                                  " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <h5 class='sans'>Services</h5>                                                                                                                                                                         " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <h5 class='sans'>Industries</h5>                                                                                                                                                                       " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <h5 class='sans'>Education</h5>                                                                                                                                                                        " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "        <tr>                                                                                                                                                                                                         " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul>" + relatedServicesHtml + "</ul>                                                                                                                                                                   " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul>" + relatedIndustriesHtml + "</ul>                                                                                                                                                                 " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "           <td align='left' valign='top'>                                                                                                                                                                            " +
                //       "              <ul class='sans'>                                                                                                                                                                                      " +
                //       "                 <li>" + education + "</li>                                                                                                                                                   " +
                //       "              </ul>                                                                                                                                                                                                  " +
                //       "           </td>                                                                                                                                                                                                     " +
                //       "        </tr>                                                                                                                                                                                                        " +
                //       "    </table>                                                                                                                                                                                                         " +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("profile") || string.IsNullOrEmpty(profile) ? "" : "active") + "' id='profile'> <div> <h1 class='sub-menu-header'>Profile</h1> " + profile + " </div></div>" +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("publications") || string.IsNullOrEmpty(publications) ? "" : "active") + "' id='publications'> <div> <h1 class='sub-menu-header'>Publications</h1> " + publications + " </div></div>" +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("speaking") || string.IsNullOrEmpty(speaking) ? "" : "active") + "' id='speaking'> <div> <h1 class='sub-menu-header'>Speaking Engagements</h1> " + speaking + " </div></div>" +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("awards") || string.IsNullOrEmpty(awards) ? "" : "active") + "' id='honors'> <div> <h1 class='sub-menu-header'>Honors &amp; Awards</h1> " + awards + " </div></div>" +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("memberships") || string.IsNullOrEmpty(memberships) ? "" : "active") + "' id='membership'> <div> <h1 class='sub-menu-header'>Membership</h1> " + memberships + " </div></div>" +
                //       "    <div class='c-text col-md-12 " + (!printOptions.Contains("experience") || string.IsNullOrEmpty(experience) ? "" : "active") + "' id='experience'> <div> <h1 class='sub-menu-header'>Experience</h1> " + experience + " </div></div>" +
                //       "</section>" +
                //       "<section class='full row profile articles'>" +
                //       "    <div class='col-md-11 col-sm-12 col-xs-12 push-center'>" +
                //       "        <article class='related-content col-md-12 col-sm-12 col-xs-12'>" +
                //       "            <section class='full row profile articles'>" +
                //       "                <div class='col-md-11 col-sm-12 col-xs-12 push-center'>" +
                //       "                    <article class='related-content col-md-12 col-sm-12 col-xs-12'>" +
                //       "                        <section class='" + (!printOptions.Contains("ranking") || string.IsNullOrEmpty(bioText) || string.IsNullOrEmpty(individualAwards) ? "hide" : "") + "' > <h4 class='sans modal-heading'>Ranking</h4> " +
                //       "                            <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 " + (!printOptions.Contains("ranking") || string.IsNullOrEmpty(bioText) ? "hide" : "") + "'> <img src='" + baseUrl + ConvertToString(dr["BioLogoPath"]).TrimStart("~".ToCharArray()) + "' alt='" + bioText + "'> <h3 class='sans'>" + bioText + "</h3> </div>" +
                //       "                            <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 " + (!printOptions.Contains("ranking") || string.IsNullOrEmpty(individualAwards) ? "hide" : "") + "'> <img src='" + baseUrl + ConvertToString(dr["IndividualAwardsLogoPath"]).TrimStart("~".ToCharArray()) + "' alt='" + individualAwards + "'> <h3 class='sans'>" + individualAwards + "</h3> </div>" +
                //       "                        </section><br><br>" +
                //       "                        <section class='news " + (!printOptions.Contains("news") || string.IsNullOrEmpty(inTheNewsHtml) ? "hide" : "") + "'> <h3 class='sans modal-heading'>In the News</h3> <ul class='newsfeed'> " + inTheNewsHtml + " </ul></section>" +
                //       "                    </article>" +
                //       "                </div>" +
                //       "            </section>" +
                //       "        </article>" +
                //       "    </div>" +
                //       "</section>" +
                //       "</body>" +
                //       "</html>";

            }
        }

        string apiKey = "ddb50846-afa3-469e-ae90-5e20fae184e7";

        using (var client = new System.Net.WebClient())
        {
            // Build the conversion options 
            System.Collections.Specialized.NameValueCollection options = new System.Collections.Specialized.NameValueCollection();
            options.Add("apikey", apiKey);
            options.Add("value", html);
            options.Add("MarginTop", "10");
            options.Add("MarginBottom", "10");
            options.Add("MarginLeft", "5");
            options.Add("MarginRight", "5");
            //options.Add("HeaderUrl","http://manattcms.thinklogic.net/cmspages/header.html");

            // Call the API convert to an image
            response = client.UploadValues("http://api.html2pdfrocket.com/pdf", options);
        }

        context.Response.Clear();
        context.Response.ClearContent();
        context.Response.ClearHeaders();
        context.Response.ContentType = "application/pdf";
        context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + HttpUtility.UrlEncode(filename) + "\"");
        context.Response.BinaryWrite(response);
        context.Response.Flush();

    }

    private string ConvertToString(object obj)
    {
        if (obj == null)
            return "";
        else
            return obj.ToString();

    }

    public static string StripTagsRegex(string source)
    {
        return System.Text.RegularExpressions.Regex.Replace(source, "<.*?>", string.Empty);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}