Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32D6D20F9
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjCaM40 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjCaM4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 08:56:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D927114
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 05:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l996qr+osXAha7p20PUO+85FtPPFtMFoTR5pqcONL754QGnL3tqKPgN3Bx0ol8fJSjgvLQ6zkzBgqqAchDRabWT/qakdlu3XvTDoR0QxzCpod+fJu7lSQz4Z3bykoQsjI3jOQeOn+XlHDUiHjIOsgtufnrAUjE5ItlMYpgeDNaWf5Ijc0WrWQLR71KVwKLvAnbKc61motNG70+5iaIzMtQVLJOs5iHf9EI6D8dL22RUc3BMz8VSgOHW19vsq7cwB/3V8w2twApf1OfUWgoe7Qlz4PCvVE1Z/o8TCvQjjGnjZbN+Eit5FCfjR7htbIKpyYadr+LWW6H7C8GdVFlY8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipNATpTviL/t7A2zRI6txGm8+81NwibD+I53MLp/kL0=;
 b=oImgMP/SPaWt5CaDvY1jO8PBlJjvIKr+ijYJRyF9SCvPCjezI8W9IpA3gTyh7s3tBMu51To1DJSnsDi7Z34Zl/W34FkKC97/AiMdWdgJuP4scm4j1BboWuaIGR6aue6TmKCFzkKIE+4vUVeWoPRjR1AK8MQT9A499CT37OpGzoBf1ceiCF8YZl7k9wjvZw99cIwAGzwyljGmeYsjVPCTQgSvs4RtU79KYGR+HOWIy7PpVa1S1swUq4hZ7pYi7pq7pbO1uGDlpH1C/IG46NCyxoNv0grnSY6Nro2rvokTCIp+Hv30XR01fB7sf4huNUhB/LcfRmB1jn/pWVsB+0Nzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipNATpTviL/t7A2zRI6txGm8+81NwibD+I53MLp/kL0=;
 b=ktgBeen0SyheemX9G4QfRmKNZNfsgjjzkpV77kyitj7Q9/9E1sCtCaDQZQdnC/jFDLAGO8d1XdyYtfhWY02VvP3BfBW8z1t/E7e4An+vWZSqxvb++SCT7KBxGBwVJRC43C3WgJZP0s0HVJGxWwL6yT7kCE4ZNuk36+k9/+KLG6TdCUpV/MFD+yC6Jei3+JsSw2bviseoEEXRjXvbsCnKaAzhpFbWsMUQIDh+eiVboUx+xZcOJrkhNVNEsUZ5F1iLbfSP6MOXyRnVFP4JNlKTX54geNHFQgrLXhPgDII+D9PTvLAcyxkzXwTLpf9Ptw2EVfuveAUXpKdzTt6JTmPh0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32) by DB9PR06MB7595.eurprd06.prod.outlook.com
 (2603:10a6:10:255::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 12:56:21 +0000
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::73e3:8c3b:7d69:32dd]) by AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::73e3:8c3b:7d69:32dd%3]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 12:56:20 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: [PATCH v3] can: isotp: fix poll() to not report false EPOLLOUT events
Date:   Fri, 31 Mar 2023 14:55:11 +0200
Message-Id: <20230331125511.372783-1-michal.sojka@cvut.cz>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:803:14::30) To AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3749:EE_|DB9PR06MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: d50e4603-136f-4fb3-19aa-08db31e75329
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jV7UpmHw7S0eQK+1UwLMcqTxTt/qkVxgSdiOAAHxkcyykidoaaUC3Kidtr/wVIy7oFMWrjFNUO7eVp0f1nKMX8rDEIHbOuUkjMWlV5IcD7iY3oKf2K9912I+SfFNtz5943EHgFs14+OK5wfBv//KVBqU/zYMqgoVzwBrtJTZGIQVdcPYidDg3lzmR6p/vcY52/K5DKNC3AgWz5jXQXD9T/+UkMxbL7CO7x+0GpJMoXSzLejIfNJY8MhAJuzje7Se8FOlivHloBLonykfPc6GgCkHvjvizdiVgG+G6ug6dkAp1rR/EwvyybRHHaQ4LpARUS6IzHSJ+VhVAAvQWbm8dZTYXuPAkkTNGcMPB/npuDp9MymAqiTiPwafwREvJAvEZ9moUsdOl1XYmyiIeZ3KOP8v8FTXYTQ1NqM5p/KN8JQVXvJC6AlgmvgKactIAhc+6UQPk80DONCjxGWSnEx/5Zkfx2nZ/QJFk04wZ6MSb7yVzTFj357w/w4EC2AGquJYtulFATEqPSpvdgSde5jmExTM0bm3xRbxtXGY/rYMbh7MAIKh8BNhtuJTCmRy6reF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0602MB3749.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(396003)(346002)(451199021)(41320700001)(186003)(6512007)(6506007)(6666004)(1076003)(8936002)(86362001)(5660300002)(44832011)(66556008)(66476007)(66946007)(110136005)(316002)(83380400001)(26005)(2616005)(41300700001)(2906002)(36756003)(786003)(478600001)(38100700002)(4326008)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyNrl+IcMve+igZavOLSnbCojry8jKUjRY16ax8pdShL0aAUyn1mrXo2aZTp?=
 =?us-ascii?Q?fAW1g0K241sqbFVmrwdwhs0CrjrivZ1kyJ38LAaSp29aXW+or5lwU/Xl2Y6s?=
 =?us-ascii?Q?XHcp95XvUJ+EvnAFeddpoj55aK6StMZmWhuIEVlC6dioKtKhXfOyCZW3S64p?=
 =?us-ascii?Q?4at/NIAWVm3A7P2SNf4EIsWKa+bV6vQhgaJ9wQ7Vs6P/3aP69EYWNiZKcUNQ?=
 =?us-ascii?Q?d5Tt6TkgiUh8lE/xUL3V+XJosvFFQpbMqZ2P6mzRETP8W6SwLM7vVN6fRmP5?=
 =?us-ascii?Q?eqb3J00hM7J0G0a3U/6hqz/x8DcTxMe97rZB26B+9/bnLqbZ6a83wjfuQBDl?=
 =?us-ascii?Q?9Ws5HhcSoMuEAvhiZQ/20yLQ0B0PPvxcsz/vg8BST7FX6FOh2248cNtighib?=
 =?us-ascii?Q?s9FlhlOcJi4YUn2vks0pltX5lJW7MUfJm5ymMaLrLt5gbUbxU/U8rWYC7/fS?=
 =?us-ascii?Q?d9C/5l3xusFc/EABDrtDiiCJcnlTM3+SC26QOnXDg7FH0A+3P65Sir3aC7UX?=
 =?us-ascii?Q?0/yp91tdQWsoViyGFR6W5iH7irsfzFXbFb29lFl+uXTEo/4xVXnKgtrqSyXA?=
 =?us-ascii?Q?/HY2vt0HL3G+/SWw10tW5q7qFl0mniM73zD2E6/1dmkpIBxug/qwGsesj752?=
 =?us-ascii?Q?Vniy8zbX99lFj4rY52bY72NxY1EsmUYatro3a5iUgu/H/rvf3ztOtmUmy0Vw?=
 =?us-ascii?Q?ujPi+01UaVUDmpoLNnnRGKORcxsp4c0u/vaMdDsdtihUBnQ3TP3JFDLYMAPy?=
 =?us-ascii?Q?rmtQ187NC4VPnY01r7+qphTrQkWKCpR7kUQMw4h7gFaG+7j+H36Ie5I1+HFu?=
 =?us-ascii?Q?mlY8vC6FJBefK8YpaQVgigTSXtWSKGH12m4AjabSAPjv7S7S3//I8S1Jjd6c?=
 =?us-ascii?Q?l/pOYOXbMVQaCHsSdW9C+2YBhKD+yZqz8KORdrkZXiVZbKXoVA+JzI+xnaUu?=
 =?us-ascii?Q?Qr7tBdU8TW05kSU1odcNckCGng/xPkgXRj/UtecrWO3kEYW0nDW4HgPn2cUL?=
 =?us-ascii?Q?LNLpc+fAjX2eUqvaUluOpfylbENjSjlaC6RAIEZaVWZBZ90VV4kKU40rzAqE?=
 =?us-ascii?Q?5DSJpLBrufTJbMg21BnhtTwzL/eI/V4wx5hpum8Tma3j7q/CMuzwGsjjdofv?=
 =?us-ascii?Q?VmZwqnAOhalANoDkf2LewgcjhR2Yr4WSqtJco2AQ3af9rahOFwwbJfcR76Xw?=
 =?us-ascii?Q?nw5o1g6W8QYujqOd1cNu4c2Vmb+aj2VuxKNn1DQ+7jS7vOXThOcKLdqqp5DM?=
 =?us-ascii?Q?H4vVq3DqvkDnFTpD1sNNnir8flBRhcNuPPFX5V7Ol6f2vBtaHJfzAU8otwzP?=
 =?us-ascii?Q?OIApRXqbq2XNqYxGVmE9PvTbsL0g+5jOS+6W2iGvro++RNe9hk8IdVmB3fNl?=
 =?us-ascii?Q?goAf6dLS9gHZLEissZi/ovlbmzeqzle9n5nULH+2VjYU0r61fvbV+yCtpWo+?=
 =?us-ascii?Q?TAOUxZw9wJ3mFClDOz+5J7BZ9N514zeEiBmBSOTLji0EO1qHIoxE9HmM3sDP?=
 =?us-ascii?Q?rOmO3deARhVgakLL+KPr+pmY+ZztOxSe3hm9LchNJw7D+kNQefjVLvgCP0pO?=
 =?us-ascii?Q?DNa26GtNhVYgKIO6NyU=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: d50e4603-136f-4fb3-19aa-08db31e75329
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0602MB3749.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 12:56:20.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0eUeHybrd8rbA2/X/QxG1uijAoMbJgdBhW+5uG+mu93M2nSf/OF+dCS2yDVpkm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7595
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
Changelog:

v2: Added waiting for isotp-specific wait queue: poll_wait(file, &so->wait, wait).
v3: Trimmed the commit message.
Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
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

