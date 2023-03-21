
As a part of today's practice, here is what I did to solve both of the SQL questions from Data In Motion, LLC week 32:

➡ Simplified the table selection using CTEs.
➡ I used Dense_Rank since the question stated that "If two artists have the same number of appearances, they should have the same rank".

You can find more information about other scenarios / use cases for windows functions used for ranking here: https://docs.aws.amazon.com/redshift/latest/dg/r_WF_DENSE_RANK.html

💡 𝐖𝐢𝐭𝐡 𝐂𝐓𝐄, 𝐈 𝐝𝐢𝐬𝐜𝐨𝐯𝐞𝐫𝐞𝐝 𝐡𝐨𝐰 𝐭𝐨 𝐛𝐲𝐩𝐚𝐬𝐬 𝐫𝐞𝐬𝐭𝐫𝐢𝐜𝐭𝐢𝐨𝐧𝐬 𝐨𝐟 𝐖𝐢𝐧𝐝𝐨𝐰𝐬 𝐟𝐮𝐧𝐜𝐭𝐢𝐨𝐧𝐬, 𝐥𝐢𝐤𝐞 𝐃𝐄𝐍𝐒𝐄_𝐑𝐀𝐍𝐊() 𝐭𝐡𝐚𝐭 𝐝𝐨𝐞𝐬 𝐧𝐨𝐭 𝐰𝐨𝐫𝐤 𝐰𝐢𝐭𝐡 𝐖𝐇𝐄𝐑𝐄 𝐬𝐭𝐚𝐭𝐞𝐦𝐞𝐧𝐭𝐬.

➡ To perform the final division in Q2, I used Casting to change count from integer to numeric.

💡What was the importance of that? Integer division would cut off any decimal portions, while cast to numeric allows decimal calculations.



[Memorial Day (Flyer).pdf](https://github.com/idada29/All-SQL-Analysis/files/11027981/solutions.pdf)


