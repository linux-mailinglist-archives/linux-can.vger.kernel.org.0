Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDA76314B
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjGZJKo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjGZJKJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 05:10:09 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639103A89;
        Wed, 26 Jul 2023 02:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hamM460N4oKqWbbOBRnWblzSOYnjUzAIGc4KCu48mxfeEpNNdw4HKqagn6V6Enf747XpjlZWXHbF25WbHO4juNIQ3qF9JVJm5ClFNGhPAfgW9V1EZlNq5G2+xub0VWMNQhfl6xLmh/DJuR+6msqJZvoWTHGQK3htWwLsNuNralof76d3IKGlJF/cpcIBaeBAjLZB45NWtXX5XbCcIjmVVokRd828gfas8ielmzE10ayfzG3LOt6nZFx0ahU78aAhS9KnQvUA8YOkgAFmiXnWkRsfaZPqF+3ni8kiZinyXzvHDbgBaiki21Qj2m+pp3O0UXFGhauAoqywYT/v88PEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM8ezf1mfsTBAcluUcy9r5HSykVDS01DHMSVGLkGRPc=;
 b=UqVnZHQK7nZReYApzQGRjaZpNuQZY4O2ghcqBtT1Rbpvg+U5qULPTVnl03nIkja6oHh9CxPdM4CP40llnfVcomIPtP4UDx68lDiEQ2FT52S/rUazJOdZB9ukYGOW2YS8NbSM+UJHQ7wB3Hx6rYQUajhI7iuGDlt7Y4n5oR6/LT1JphPP3yz+GKHgQdxs9kucczggnKx0gjf/JWteWZYf3h6O5Lxk4Vy+ymGRvrWKMzyHdrsxjpcrTiKGbiIgaj+b3Qs53ytCvwrKIS8HrAeCxowGG0BY34kuV6QkDZFnmfq0quQVxVzYSYkVY+hQryXKBvG0Z3PqaoB0/QKKCtttpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM8ezf1mfsTBAcluUcy9r5HSykVDS01DHMSVGLkGRPc=;
 b=AsV+BOuVC4q8sh7eTUKlI6gKf8jVjyChTmxm8hmTNh0E6KY8unsshrQyZzHSUaHSpl8JeFFDzmL1oFN7MZFlhJYMXHDBcdMyGvjWNwSwn6ZlyvqhAH/uPx5R0sJU0RidfpR1eGocTUBcQljBu+BtrOM5lMdQjNzT8nisZWDAhW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 09:05:40 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 09:05:40 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 3/3] can: flexcan: lack of stop mode dts properity should not block driver probe
Date:   Wed, 26 Jul 2023 17:09:09 +0800
Message-Id: <20230726090909.3417030-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726090909.3417030-1-haibo.chen@nxp.com>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 935170e0-bd15-47f8-e939-08db8db77c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pJRkkk6ttoK2Owi3dB4vowZsi08h/db+BNk2QUvwhJBl2qfnBeHeTPmPpcsJBDaoEIc9YphjTlFuRRfEkZAUswXnrHkFB8GNNyqPCQBDyeG9DbWK26lj4nRofvJ/fUBkRKebGvQqxRuRsMj5l1AKggTaBxxVbfPS0WVPESrDwiabUaTcNb2rkBjcCgR+qv7XxH59TrPgiTl7+eWJp1ETpnj5eq9TbOlrOuH/luEKjMhyZfuUqR/1NV13Wi1aLiWMyiFv3WawKpaaTYlge+P3LEePqyjWW9edDe/MU7hmju9uUhC/Qvn7KNGMzITJ27SMSQ1veANNUnIF/Ns1BiobGNhVGXQpcTN7UonPfePMWMPp1WE2W7QgaTH8uOTT4bUIlJE+q5p1R2YOyn9E9AMiG0evVRJZ2lgpHbVzgK70HYOPhC7sLV/dy9IIJvurWWLA96W86dwBS8riu680lEQy9FeRteqLeDs7CJkxJqf4AnJ0j+rscIuDh9z49TY0kF+lLjj+DEL9SAwQgMC7f+v3NImWphbIjBg1MRJCs/dSMW/1Twydn5SPdZg/CJ30aIRnZd6Z2kY5Gl8nFzSeqPclfg8Dw21SvuLu6BOf2AiKty4aFBlgKz+JSaXnD6iCCMb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(52116002)(6512007)(9686003)(6666004)(478600001)(83380400001)(86362001)(36756003)(2906002)(186003)(38350700002)(6506007)(2616005)(26005)(1076003)(66476007)(38100700002)(316002)(8676002)(41300700001)(4326008)(66946007)(5660300002)(8936002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJaarLdx9m2On/o9X48wDpgjaNeGhGTgKq/WRktOJ5b5eN4VYiQIbHalZwct?=
 =?us-ascii?Q?C18/Mw4xijbrx/WMaT6Tluj0TooKXQMAH8MPAC2tKbgj41Xb4K7Qp8tFWVX5?=
 =?us-ascii?Q?aW8h2ujWw0zmpuYpVwAyx36bmSABl3aDBj3RasRNCkc67cy4T4gw2QfLrFDc?=
 =?us-ascii?Q?cgx3sKQsK+DHVaryAwjPHsXrZtskH5egT7kyDWUWUVKtzVtearEy7xJj59kG?=
 =?us-ascii?Q?KCu9Bp7DJVQ5GSn/Zs4dvrFXPRoJTYTDv1KzAmiIpD2Fuq/nkJbqLYWGlccR?=
 =?us-ascii?Q?BMEXyaDFax6Q7lMjPVc431lC2SMscOm80EdomppMz8sfUPv+dQUWslAkOmLh?=
 =?us-ascii?Q?ey/kPdBiAodJTZTcM5MDy0HjAywoqTVQ9+ADx4XIKvYkR+PeKSMEnspmj7wA?=
 =?us-ascii?Q?te0bI5b1LtpmrXNNtVaR6EBaBU41KaTYMdCxYbiLXsP5+lEgCSKOEsg5aPbe?=
 =?us-ascii?Q?+P7i3MF31bZymYeFUFWvvwQ8cAAhiHOsmusv0HfnvMcYiA2+2UREUhEjmpk0?=
 =?us-ascii?Q?ZwbXwtbQnndsnMiaJCE9tdZ+jffPqYhUO9emxy3JsfmLnELSDSsySicvXFrs?=
 =?us-ascii?Q?giI34SMnHsys2LfRm9uDjQv4fw7uy+MPupU0JAj0jQtYFOEzUXLcZQQh+NgL?=
 =?us-ascii?Q?87aAReYSI00JaLzLxa7RTBd/L8P8viNqqHwZWhqSjDdfb18uVkYibPkoJssc?=
 =?us-ascii?Q?vPIHxw9G/KQt3B15uJnC8FTHoKDhDaR5JBkI2GtSchtFUaFfiXxdp8azMkV1?=
 =?us-ascii?Q?kf6ZsgUOZWj1wfnSUd8eutOeYs/ww1p45ai3lQzBjO5QEX4jrm6KSwOX+oec?=
 =?us-ascii?Q?C5Q4MD3100FfkBfChjd5TaTqSbTLkSwni48AHmhshiAqsTVjbdgUt3pqw7oc?=
 =?us-ascii?Q?32FcVB9g59YS+/0gPDoUfjHTldWV9Dbj0U6muz1VQAzUw3KRF3KlUVOAic/t?=
 =?us-ascii?Q?Xw/I99KcjBpjQopv/8pzgnRu142XF+CVbC/iki5lPgLzZc5L2g/o1p5Dg3w6?=
 =?us-ascii?Q?fvjG0RMM6B9Nk5YiolpbXJDF4MBuTCnlq1z2PCgRkIyOYOKAYlZ3PvCTYnFX?=
 =?us-ascii?Q?S6gOktN/52amyMpPyeVHM+cTViCYcBPQucHNsZm8cfr8lTjBWGo/mo01vn8+?=
 =?us-ascii?Q?DQMDnHQIJHElLOxLRjbcDhpGoajr1UUD9RdQvdadWQPalM0LUStF2vVHRGA9?=
 =?us-ascii?Q?b7O5ON1R3/Cenmd8bmvCNB6PgNUYljKtQb1Hku6GAkrFC6VtNACmg4H2ZY7S?=
 =?us-ascii?Q?2Ih4xDfL7ehrI2zGwCFTzZK6KQ7qbHj/5q866HkpFX+ugbPAjtp3azjFYINz?=
 =?us-ascii?Q?YCme8lCxJc/mtiiHjuASCohpSPG9Pei6QhsxoAo0sBkaHQacjDDme83OuJru?=
 =?us-ascii?Q?5e/LsAPV0I9Tsp8mCTNWUGw0G0T0d9FO3d9JKut+He+Xuy1Sty8pmN/E4PME?=
 =?us-ascii?Q?cD3ObGkMLyg1l3ImHDVlWAkxR8tPKjcwdCcZgSTh3BU5ZchCsoIfWX+LUIKy?=
 =?us-ascii?Q?xaeJOm7nzDhb3UcR9lMaMvcFckO9oikW2/0zhFcmiZXSHkP6zOogkk3/ceYw?=
 =?us-ascii?Q?M46ycf0hoVwIQaF+HQGV74NqaMNE7LUP900O9Inc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935170e0-bd15-47f8-e939-08db8db77c06
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:05:40.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZVlQLvBnWEAF8wLC4W8PNzDMqDQZxvC5uZggFfSThupurZfuhonn+PR5Ora6ZPXbE6RfLsmEM6J+YzJqaLbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

If SoC claim to support stop mode, but dts file do not contain the stop
mode properity, this should not block the driver probe. For this case,
the driver only need to skip the wakeup capable setting which means this
device do not support the feature to wakeup system.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index a3f3a9c909be..d8be69f4a0c3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1987,7 +1987,14 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
 
-	if (ret)
+	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
+	 * dts file lack the stop mode property definition. For this case,
+	 * directly return 0, this will skip the wakeup capable setting and
+	 * will not block the driver probe.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
 		return ret;
 
 	device_set_wakeup_capable(&pdev->dev, true);
-- 
2.34.1

