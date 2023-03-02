Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A236A7DA4
	for <lists+linux-can@lfdr.de>; Thu,  2 Mar 2023 10:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCBJ20 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Mar 2023 04:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBJ2Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Mar 2023 04:28:25 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2097.outbound.protection.outlook.com [40.107.241.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10815577
        for <linux-can@vger.kernel.org>; Thu,  2 Mar 2023 01:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTrSj4JQBCEKfbrkT0Px6Ja8Ew9Rk/1UqSMTSIkUWn56j1j8YrClketP21ptakHONxS7+8bp3dCVgIqS91EW3r7WNwD0A+q8v4CTLghchLMrd83sUYXpl1X7INjI8VqttoR/iV1TAgxh/S6gguA/nYfQNAdFDn8LvT0jR0cabKZbSzBrrP9+sRfC9uOyvW2Dal7VW56U37ixl0S/OwgrWU8SyHfQ0J7glEYjqiNj5W6h4+S/JHQfvEb8TbsWxRbBTLHn711dVqiKTqqG6G0LtAbxWyqPbWP2u9aLB4IHJQ4ALtoU56v/cAewgxRI57pxGtbLwV/WUx8KB2PtSugwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rirS+RqRQmxeYag5r2bITox3FcZTxFDd9cz4Rn+qMBs=;
 b=E0P4pQTWWdbvWF/J/WCYFbkHYWKUmyy2G1KNeeyWS0Rs926OMRs3QfYABkpt6lFdYhOfNvr6skJxX3ICQ3XeOESwdjTpNDTc5RncuDAkYpmbaQka7BU5PlxbhDUNRUyQVkCXSzrNEZtZtsgek1VfuIULYrGvvxDGWC5CrT/jKqUMXvg2mAE5pGUCO6P+MY9bUlf1voXNO6M00PnexcXOKQaZFIE85hzM5TwpH6x2RuH0WsdrEx40dXaU8AcusgFc/VJ2vRLDtpb4yXuAsDfwyu1PPUs4y/yy8dIs5XFk/nORi9h5Hc49Lvga3lLZPUsKTThokXtr4jtW03UKDMR69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rirS+RqRQmxeYag5r2bITox3FcZTxFDd9cz4Rn+qMBs=;
 b=1fzjRMQC2UG0PMFvdD3+/0xPnRnMUd7enqyWVmoO9Uq8pRnFLzxNJGzd1TBeNN0P+VhbYD9hQk+yJ7vblVjxKnoRKGItrMVsvuEOXLudgNBdL5OGBUqJCxloP6S/GdFS+68UJtir6bDn6JjpaLH/P3d2jFjGazEBDyC+Ylx+FZqb4O63EUkMCy9Re5GMlGcN8Gnq+G359P3Bl9XodsJb7oQQVSOBS2oKf7I4xD9QuCt4frJX+i3MfQbqJcWoc3y7HY5EJ3XOUpUUHG8ge8reNrZpP711zo0cMeq19HdXgxdklw03aqOFIXb1Bbjw1uQ/m06QQK/AOIncWMu1XR992w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com (2603:10a6:208:195::14)
 by AS8PR06MB7333.eurprd06.prod.outlook.com (2603:10a6:20b:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 09:28:21 +0000
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe]) by AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe%4]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:28:21 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Subject: [RFC PATCH v2] can: isotp: fix poll() to not report false EPOLLOUT events
Date:   Thu,  2 Mar 2023 10:28:12 +0100
Message-Id: <20230302092812.320643-1-michal.sojka@cvut.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87zg8vjyqg.fsf@steelpick.2x.cz>
References: <87zg8vjyqg.fsf@steelpick.2x.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To AM0PR06MB6548.eurprd06.prod.outlook.com
 (2603:10a6:208:195::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR06MB6548:EE_|AS8PR06MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: b9207679-65d4-4b16-15d1-08db1b00771e
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud/Ag3zEjkXN97vuop007FfjTX47Dm2xFvAJdNsc461oy9You6WkH/txaxnoazMVV7WAGoDxlrW3Whidmu9YD8sDgma6cHSKgq4r2dmn6jgS5SHTtfuOTP0RLpkQaKzsJRhwOEsmKdpMPkgufmrf5ndxTrhWR8rtJohG1MUgPkHQ+OGkrLL2JQmT9UuPnU4NTq2q2AV9fly/aqOcEO8glSyDWmJWDcadbI1BJ+EQgzJCQ3CnKZ2OSJMx2ALWRfe/FlrHOc3d9fETY4KenNof9gzu3HvL78nslgw9uggE9O92uHGLB9wAI5XvXWfejFYQaJZq64+IUVluuc6m3ymOCHRNnxQcyag5dH7T2fXJBwckHy5gaoh7ZW5PdvJrGqoPC0VrJx8wbYM8GVPCPKyDm7wlhU5ddada43B3P9xGQyzxgl4j6XUxHIfI3DZDF0xjIypnVRQ/F6DDtTNDoeCHs44KCY+AtRBlWEaRmZT2iK3TuUClGriA8tMKhGw+hCzRHJBig47yiIwSGRzt8ENAfoqVQkeK1uw6afKtqSKKKW5P/Asm7PPIqSMWaqB1UXcFOzIB5J3HpFhRmOMuiZYhWubRV4XxiT61uPjf5JTVjkmmHBP8IX41zh3aEk4JKbBu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB6548.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39850400004)(451199018)(36756003)(66556008)(4326008)(66946007)(86362001)(2906002)(66476007)(41300700001)(6916009)(44832011)(8936002)(5660300002)(38100700002)(8676002)(107886003)(966005)(6486002)(6666004)(478600001)(316002)(786003)(54906003)(41320700001)(83380400001)(26005)(6506007)(1076003)(2616005)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1qf0rsrTxZtnZ51mqVF8RG7l6I8v+NjBITBkxwp6V+P+nFkl6V6QJttU6aH?=
 =?us-ascii?Q?fA6IRRSpXOgbBVtLtMg3dR8MhXv1T0MsoFpdsA+DWhjd+EfOs6F5LUX85q18?=
 =?us-ascii?Q?mGy8ZmNP0vw5+7Kv9d1Uv8djlxMyAM6tkknMIw1ZM9spIU+M1hRlDuj0WqS8?=
 =?us-ascii?Q?D1d/mFEtaKYW5vyLNRfXcykxwKNwa1zGkRM/TTmSrPlYczKwDHpwvS4T1Djx?=
 =?us-ascii?Q?mUpFJi4On3Pir3WkB5ckPyAkPOWmPx5ENU11Xj9PEuWToHAdwv11hd6WuuK6?=
 =?us-ascii?Q?2hOHS56KydsHGED8+jTnHarpFHID8xBUhpONAQiTK15zFFWIa8hOswHcG88b?=
 =?us-ascii?Q?SmVypXXPOksj5g8CPZ3ABEu52A5QQ3+18RpBgcWwSjZ7lRA+C8931RYXCLdN?=
 =?us-ascii?Q?oir+NE32AI2B1Pweq39rcDYP3UT4jX/dQNs2MvIjF1s9XGaAPTItgUW00C1T?=
 =?us-ascii?Q?YM3VHdkzONau1dpWUjWJR8K5alGdnmxYqnKH7o1AHmTuotYrXiI8BV5bSej+?=
 =?us-ascii?Q?C/ChPjCTMvSIEuefTwDh2NH1z8DTBSYsjGVeaG8iWEpp/IOQLMMY+iOFxHrM?=
 =?us-ascii?Q?w1oAGquUggffQNBLdycqeivQC9JW6XF4CXZffByRjVBbSpc6rY2JjrjNGYOF?=
 =?us-ascii?Q?LY/cPcCZohHADD4V1f4lZv5CURuaoZQuKsrzMGZl9LdPi8Pa7ndLyM6uTKeh?=
 =?us-ascii?Q?29H5py6AeclUJyMZ63/gJR64TFN8t99oW9rV3AkCLK7So2GvIJ8pS51d9Z8H?=
 =?us-ascii?Q?TQNePmdyYiemo9+lUFb1g+DH08wux6zMwNyglZo6tmq57wCAYqrSTkQNi+8v?=
 =?us-ascii?Q?Dh4dOAzvm4AKpRUfk1iKx1iBO2mix6MsZVBF6HK20FrvqfCp/8P9XE8VGAyS?=
 =?us-ascii?Q?79aQkEjd8Xzhry/IrlLF/qgx7JlyH1fjB6EUaPjnQhKAoqsX9AHeP92kpq3H?=
 =?us-ascii?Q?xC4WFF+YmG0hS2OzGciTTL1Y9WKLl8XB5R3c6UodWdnp6cJUlQbyoY0TU42j?=
 =?us-ascii?Q?1yqfUcfHJaQH5kq4tFpBV64Uos5SZ47iZCvxCFtE3qsMhGYKQ4z7gUJt4wHX?=
 =?us-ascii?Q?0HdwFMuCHoQ8tjBDR30w1ro0cCoxA/qywB86SjJugucI0U9VATLJELu4Ilfz?=
 =?us-ascii?Q?bCDFVk/QzyTZVolwqtrqkDlq2f3jb1Upe2mbOwtNhGUpKjMMJ53McmOru0wn?=
 =?us-ascii?Q?CdoUIZjDXSlW6XdST5Ixw/t4ra7Blb4iBTmZ//5yjyC95VIXBsocJVVPmse+?=
 =?us-ascii?Q?UKSE0niBRSSAaJ4wzcWMl5+ZtWyqukA7Onhzt55BOrlUBYAkOislKtL+ZFnt?=
 =?us-ascii?Q?fOld19Ezs4RApFU1LhCkrtTNVL7rSN0n3obd8HSlcMikxfJ/ZYMp+JjQGel8?=
 =?us-ascii?Q?WwklAkw+1mU2zLTHxJJIPZpC3qiJ3tot99bmLv9dvo77OfiF5Ifog7+wmdu4?=
 =?us-ascii?Q?1yMXDhUy8MiLwI7BTSGUNH+pqCo6tlvNFAjvm4E4W/8k6Pj55oVTHJib5uyU?=
 =?us-ascii?Q?l5wDkIt5lpOZSFfiTYFBZYT8rA9Nl8mM5fP9rRjS444twM4ab/UB67gXt1Q6?=
 =?us-ascii?Q?ww6wH04Fz6EhE2XD1zo=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: b9207679-65d4-4b16-15d1-08db1b00771e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB6548.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:28:21.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/x8KsLTGBu1diHn3EVxXanGVZUGL/Rx1OAGsp96X7DrjHI6XM5+s/mTWt7K33TP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When using select/poll/epoll() with a non-blocking ISOTP socket to
wait for when non-blocking write is possible, false EPOLLOUT event is
sometimes returned. This can happen at least after sending a message
which must be split to multiple CAN frames.

The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
not equal to ISOTP_IDLE and this behavior is not reflected in
datagram_poll(), which is used in isotp_ops.

This is fixed by introducing ISOTP-specific poll function, which
suppresses the EPOLLOUT events in that case.

This can be tested with a program available at
https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf5ac9f4f47fd002c7/isotp-poll-test.c
which can trigger the problem on a vcan interface. When running the
program as:

    ./isotp-poll-test -s 123 -d 321 -o

it starts sending ISOTP messages that include increasing ASCII
numbers. poll() is used to wait before the next transmission.

With current mainline Linux, once the message length is greater than 7
bytes, write() returns -EAGAIN and the program terminates. This should
not happen, because the previous poll() reported that the write()
would not block.

After applying this patch, the above command doesn't fail - if one
runs some ISOTP reader such as:

    isotprecv -l -s 321 -d 123 vcan0

This test program can also show another problem. When running:

    ./isotp-poll-test -s 321 -d 123 -i -a

and then in another terminal:

    ./isotp-poll-test -s 123 -d 321 -o

The first program receives the messages and uses the counter values to
check for lost messages. After a random number of iterations a lost
message is always detected. I believe that ISOTP should be reliable
protocol, at least on vcan, shouldn't it?

Anyway, this patch doesn't try to address this problem.

Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>

---
Changelog:

v2: Added waiting for isotp-specific wait queue: poll_wait(file, &so->wait, wait).
---
 net/can/isotp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..ec163e36ac53 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1608,6 +1608,21 @@ static int isotp_init(struct sock *sk)
 	return 0;
 }
 
+static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	struct sock *sk = sock->sk;
+	struct isotp_sock *so = isotp_sk(sk);
+
+	__poll_t mask = datagram_poll(file, sock, wait);
+	poll_wait(file, &so->wait, wait);
+
+	/* Check for false positives due to TX state */
+	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
+		mask &= ~(EPOLLOUT | EPOLLWRNORM);
+
+	return mask;
+}
+
 static int isotp_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 				  unsigned long arg)
 {
@@ -1623,7 +1638,7 @@ static const struct proto_ops isotp_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = isotp_getname,
-	.poll = datagram_poll,
+	.poll = isotp_poll,
 	.ioctl = isotp_sock_no_ioctlcmd,
 	.gettstamp = sock_gettstamp,
 	.listen = sock_no_listen,
-- 
2.39.2

