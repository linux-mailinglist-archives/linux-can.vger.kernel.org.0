Return-Path: <linux-can+bounces-7565-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBbkBZ2K/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7565-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7154F2BD6
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E261B3047747
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A437B03C;
	Fri,  8 May 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="FAtMXN+b"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021132.outbound.protection.outlook.com [52.101.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167E3783B1;
	Fri,  8 May 2026 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223705; cv=fail; b=QQS64yD1kvWkSuogBgEyIItsqhKnrj9ROb/kB+Po1NdcXG1LplSA6aSuYNaQLeTR/RUliuIcxRIlLYzpmKjF7NAztXU2DwTcx92eFZbuVe7DpDSluKtS284lCFJ5RN3mMr0sh+njn3IIqlRDThgrJZGQbs1VkRGEiNXfkPoNQBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223705; c=relaxed/simple;
	bh=3LFE8CzyrZ/p20GVqI5aJ5/Wr/1VHCvebowKEoxQHcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7Yddi7x2+pvOMEp3GQF3VRFkyxtNfW3f+engXbWvRkCOnbb/8gbd7JEE64ioww1iOFT36cIqI+BFIuyaxyDuQJA6TpEDZs1V7ZyJp0iSie91grm0lxAQK/oM3cISv3JNg1J4sQ0a4mgLJPrHN3Aplc3WxoFep5dTfq2EtbwUa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=FAtMXN+b; arc=fail smtp.client-ip=52.101.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD8FubzRU4wNmuk7tuaAGZgWMpgJ1HrXhDgBnYPqv09VpfZuhN45ZMD6w9vyBc5Zx6BKVuDiEB6o/C/FTfevMZUJKpYzNw46jWijc7F55jyLVgfQRks7/xANqCtyifgIV8wyT0GHm5D8Pcd1kYB6ECfD+FYfHVeQ8+IB6MANddmtZgUPHCrMeBDEfubUlb9+WYSRA0OisC6ihdHwUMFzNi3VPgueFl+DOvXHaIE+2cqVaYQe502i5UiPtN0Khc84G+E5DGf0WL47teI8G9V4k1yx6nscCvXTUW4pX9SUV0aFo3jmx9H83ciTznQxF3ywbizEQZLUuF/hNhi8ne7uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qCN5JrFpyFQZI/qdZzwdP2aAE4CcSJdh5LU7VVuuqk=;
 b=HDf9cCgRA5gGw/0ZcGQGvC8I2jmjJ+nZNl9lF0L3RsEu+WCd5mqKbO95TAfLMtn5say28PA7Xj547pOOnh3FFgyH6fOqChByn5212iBatrsehV2h7UnkZgw7+fXAZ1U8z41viO1ywz/b7N/4AzXFp05QHSqoKimdOKbbO9TywTA7LBAw0ElfsaYEjweAD9oldojGsckocPdxoBsyQlsICM2W3Tsc/+GOMQuz7QCE/2hU4FrDYuCeB2QccChZP4VlRvHdTkxwa3iYGRQvTTS1zwJKAaTcclp8JyyVM/rWAuoMYpibnUI4teGRLtPEznGVQDfKkVLR6AqiyvLAmN4NHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qCN5JrFpyFQZI/qdZzwdP2aAE4CcSJdh5LU7VVuuqk=;
 b=FAtMXN+bp0M3AMDLoZh8yWgjJm0dt1QrkFx6vPRx5ChdfrV0G2qQQalDFxeOOQ5XJC5Q1Ni6znpTZjXRAnN9YVpyb6bqDxSn4sKPRPFX1LxwwbJZBKcwbhxrwA+XZdBKjWYQyreLcHfhqdTcfOO6fSS6mIuF15AiTjKAb8eEVBF8bthD+iDFlilEhxP/RswxCqs0pko6cKQ3FQX1zBuhV9s5SBY9VSWOQCXgQlzE8ID3aXrcGmK4iVuIO8AZ+loGbrPyE/vnAuOiCwUvt1oDHsIHqNoOpOk++Tk6HFkldfQDPooTo/LxcCvfGCh3M7PsUFgtD9cPfxEZbCOWGYkjgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:34 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:34 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 04/15] can: grcan: Add clock handling
Date: Fri,  8 May 2026 09:01:10 +0200
Message-ID: <20260508070121.6918-5-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
References: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB0889:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a7807a-3ab2-48c2-4caa-08deaccfa3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OFjsL+jsuUSO2PrSEuVfCJIL9NUW41WxtA7r5O+pRJ/mBJT20AZTsIbUjfL0S1CQTg2ls49v+qH+d7Vd53Va03Jg4IJr6Q4f/z97XAMPcBXmr8OwiJFkmu8eexYbZSaHYIhHBZvi8iTZyeqrsqqmcJxSgCh0jVqVHSirJLyhKSBgM21XxvmaWXJ2VY/8LvPAHHd9ihJEUId/zmA49A1OqUsdvY9kiEg+Kc+/YaZC+WfxHtNTqy0dwD0bTfso9ndZZ44Nvu8ZoaVY64AqDM5Kv2/DaQ76fKmDlwPYr2JAse4ONXBlmPt1Ax1ztOc0dvmqbxpnrmHuDKMDvO7paIyWXlt7kY6QPhU2Y9JOtbaT/O3Q10Ltfc1IHAfxIyTWTSTnlAa4rCUijv/v/8JXfKyf8xuZlMetiCHhrPbgcQtxg06D0ozBeLGTLOeQcyBlm+ooa1T/YHZMpcWKrZjmzRovrFImJQ5DK9Gt+8IvlW0vBPvFY2vnl+Q2++F13I9EIYRYtCIFNDZVsi3MZGwxV//GDA6JRjFu9kT1Nc5Ol6dkzLXV88o7sU3f51ptQ+eKO3fGzRrY40NW85m882DxXlKBWu6ADAcLUo7Dsqi4p0rJG1tX+EcNLtlSoAtPLPJGah2RmDTCdr7uVAf6bw+bJjGItczI/ue7/UzBdpkQq6+yWU4xwZHrPOYJ3NtdkFie/AQ+a4NxmZBQjJ7DvRc5gGTDTjrsVEsG4aO69XsOqq2Gcqd4qef8xQll03itdo8C9kvB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYqeBxcQEN7uX9dPVH+tJ1jKetDOxG9XAXgarjWVEiRNTnXtO26Z54g1oxM7?=
 =?us-ascii?Q?jLk0tew/IjJNl7dQBNDHLPl5zbetPyvevB7CCQElSdfnZjoVSa0UYE2ss2cA?=
 =?us-ascii?Q?exUMskDhSML4/onKP5sNlvXkGU+3SgjF2R63Khrj3bmLHgxftoaDymhACo9S?=
 =?us-ascii?Q?eqIH33zRBnDo/aBV61BzFOCzr6JxXgmEOwYm9YX4T7rYqLQwYa8TZ9rFxqPR?=
 =?us-ascii?Q?6/zi8dS1FT/Jqnl53o56Afb4+QCBiLkQShe0i2B1/ZFkY4KpndEmpMlKKS+k?=
 =?us-ascii?Q?q3ydWNY/s4GB8/sGvycU4czEyOEYfRaLky+vljv1rDtLQ+tyKDNGQhTG9PnH?=
 =?us-ascii?Q?63q9PFG+T0cozpq7pvFDaryB4Jx+UUS6LBzooTxhpU3i083yWzxE/PDPAQj5?=
 =?us-ascii?Q?k8VWb7EV0YTiB71w2BWfTh3LEv/mKRVrIJ1EHCGNxFzV81ni4oOKRn1FDWkE?=
 =?us-ascii?Q?pGa5I5KOzQZYjRlXgDcPiNaHe8Mdkld3AsmAIksODpnSxc5lXQqv9SrYi9/Q?=
 =?us-ascii?Q?D+Nm1YppnqwzPRcdWAt+VBPyXZ6pnoD0AnWYr4PlPxS8j/ZlcEq4j4eT+Lwu?=
 =?us-ascii?Q?kI/OGLshmYI5AIcXIiJR3oa/XP2PIw4mbzbsNvKF6WpTwG2oyksn6I34VZVW?=
 =?us-ascii?Q?edFFh4kjWDXfRgTEivTwTZ0LL4mlPiRY3dnLp3y+YKj3PeClb1v4kWQ95smZ?=
 =?us-ascii?Q?8gX30yiYjOuP6XfZiBCx3MHHtAsVcz9IFxPSSQyOfa+C7os6wAvErY9dtI2R?=
 =?us-ascii?Q?FvQtNapZZanYrohGhtSwaM4GCuYlPwuDG0rpPFxvCgpFpdnStCSYZ7krzvAI?=
 =?us-ascii?Q?0RLz0kObn4/Kh/srmxSSVfdlHsu5+YS/90XzWElIuKV+mXf/mG8m8WDJgTs0?=
 =?us-ascii?Q?v1WjluHcXPJpUpCWGt1Z6Ir8LR4tQfryKxkrzBUu5SNzo9MaopNBJ2PC0nVM?=
 =?us-ascii?Q?qgCOgcDOx5uH1S5kepg4UNcMLu36C4t08uQy36fOKa7B/NQlt0FVUIulfmPa?=
 =?us-ascii?Q?4PRPenXcu6znhij5Dr262g0jL1fc+7NbrdpJFLFZdDR5FUk3hZu3TiF9dXZc?=
 =?us-ascii?Q?xBhJTSuJkCpz24w3zQ3R017MuUq0dczy+mqHlAqLveEoyWa647sCXRWtUUvP?=
 =?us-ascii?Q?EW9CVtBNcNPRHhLwl234n9kynvWi0QuqKTRBBUMsLhQ+ZPG9sEabYSBg1IUy?=
 =?us-ascii?Q?Mf6yc2xdRcJoxddHORtjmDZpcKw9evPkv5h3hyHfquyt2+91h3YVrYTgALnU?=
 =?us-ascii?Q?ibOLk3/PUvsy+FrPX2ydXG0Ri1P3Z+dXiNbw7EBd1H/nglF1eMzWs8CMjJmS?=
 =?us-ascii?Q?/rD6bXMLGSj8+VnNBz311cBVgjfbqRstPHzPeklvF700sQG0whW0G7WrhJqO?=
 =?us-ascii?Q?xZWxie9eizQqLk7Bvt8KhqmDxwi/qSrYJ2VTqz9Xczi8MVhjWm3mA7pQAmip?=
 =?us-ascii?Q?obdIv+gANdPqebVGTS4brYXNuKAsKh3Jec24k9QZ61VV+vlaExo4+yXqYZbS?=
 =?us-ascii?Q?RkvB8gaSqIT3wTdkFzCFKQFCjh5mZxUfq6nBvODpSaZH1G9zsT+C6jVO1e1s?=
 =?us-ascii?Q?DezTkgt3dWOgbo+g0Hzm+flOOg8N87mLhS0NICzvncbN5CclOcthZglxPhi8?=
 =?us-ascii?Q?JGzoNDXsr71MFDj/KPrJ6fRrSy0GjXDKLDZ4Pd+K2gO4aifjMTVgOjQbOUYB?=
 =?us-ascii?Q?c2SbUNF8Tju6nmsPnv1kRccBjxxefv9F3RNpnh3sa/rI+KEB5xETKWjiZq3c?=
 =?us-ascii?Q?lxff4Lotwru10xdX4xz1iylXkqh15zg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a7807a-3ab2-48c2-4caa-08deaccfa3de
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:34.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkX+pQsjW3v4gIKbptHHQB7jjX5G2yioe2Xntrj3yHxor8rEM9rAUwyl34h5QRXT4aZeFgp5xJdywQyOJl313pUfMRuU2Hnhz68jnt7m7+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 7F7154F2BD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7565-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:dkim]
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Add clock handling and add error messages for missing 'freq' DT property.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df56d..a5f750d7e2d8 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -34,7 +34,7 @@
 #include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 
 #define DRV_NAME	"grcan"
@@ -1643,6 +1643,7 @@ static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *sysid_parent;
+	struct clk *clk;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
@@ -1662,8 +1663,19 @@ static int grcan_probe(struct platform_device *ofdev)
 
 	err = of_property_read_u32(np, "freq", &ambafreq);
 	if (err) {
-		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
-		goto exit_error;
+		clk = devm_clk_get(&ofdev->dev, NULL);
+		if (IS_ERR(clk)) {
+			dev_err_probe(&ofdev->dev, PTR_ERR(clk),
+				      "Failed both to get \"freq\" property and clock for fallback\n");
+			err = PTR_ERR(clk);
+			goto exit_error;
+		}
+
+		ambafreq = clk_get_rate(clk);
+		if (!ambafreq) {
+			dev_err(&ofdev->dev, "Invalid or Uninitialized clock\n");
+			return -EINVAL;
+		}
 	}
 
 	base = devm_platform_ioremap_resource(ofdev, 0);
-- 
2.51.0


