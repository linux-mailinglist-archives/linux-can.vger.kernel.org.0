Return-Path: <linux-can+bounces-3027-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEEA57118
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 20:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526011893DFA
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3624DFFE;
	Fri,  7 Mar 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7V50YEv"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAC21C198;
	Fri,  7 Mar 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374515; cv=fail; b=QfcaOPK1blnMCJ4qQpXpCyGB8U8McpeFy3sz2Cnej341yzfUzuf98sWVaduc/mlAgtW7Mjtsdvo/JVEfQsDs9iVufqvNRDOHzVTvJ3Oxrz4cb4Vb1FvH9OByStfONQRl31O8SoHI8GsSPckkqYMMD4ESfnZQGYwA0W5Z3Dsj/5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374515; c=relaxed/simple;
	bh=mELjSAKausVg6hjnlQmtmLcMCvxIS7hpzjGeVYehRRs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QRoVPZKJG6OGmiPUvqkdQd/9Lyst5Lb01mP6txYPm66trdw4/YnQeSBpUmqu4EBAV4aA3AZ7uhm8LVjVEeT9d1qUajMpDD6Zs6oWjWOkRHosgdmvdfzHHXDj9u9jzlbiKaH4yoPpyCnxWcsw25PQNiA3LrkkdxLFkzYDkyy20vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7V50YEv; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+Tx92f6HxryCTlC4HB5h/N+Zl9HKyMk9SridFuTHz2xJr/8YC9hclpW3lj73bLqTAwEWtEwX+kfGwC+cbAO+T5Pij8J4V5ochybysaXrjTCrpS80IvjA6tS8IpKLod01q0/ckWLwXKViZxTDCUOkecQ0Cb79zD9gzO8EImOblSkHZnJT33YR4J+gs2Odh5N8a3wHoBzJg06b19hj1SR0RjbAp1e2s7GgIUEQhdJMlgo1Fxy4FwxV+OcKUzUUk6t/mTePPWmhncOxgU1JOGbjEuJHP4kZKNepICI2p0/ZPExf2BhMzOtuzCGg4OhfJk9p+yy9/2akgjA8+UrTe+bgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD1b8cjBJxO6Bu2H3Bw6dXaLQV4eL5x7iWJgIChuvNA=;
 b=oB08uYdVFNRiS/OAxpovFoqIX5p6n6O5+zISvXDAEic2ehzikyhficsTygSaSdxYz3vpmWy1MwpOG93g+uviq/0Kl1LlvZCbKkTy0Ja0mRnlDs7OvjLVR07eBvH9gJq74xFCLC4YrL9FxESQ8aISBQJ0K90q5xZXJwIPlNWIEfkMI2Q11MN6Njg+irXJ6aRhGQ4YxHw7eDCQ/Jg2VUGfmLXPG2xTwSI0AFPNhhEfXTCCimQMXPl73w679MHULnZIjdzBzqu9bv/sJxRFnEgWb1vhOT5kLsVtl4lWtUXAuSjDTYZgZ0cwyJNBIZqZ4Z1gvCrXxmkI6W4MFgKslt02/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD1b8cjBJxO6Bu2H3Bw6dXaLQV4eL5x7iWJgIChuvNA=;
 b=b7V50YEv+YJ6WFPSIGhZr+9deUxpMC6/xBVQQRJ7CjLGToVBDcLKO+fYEC6tKZv5ZPuHmqE/DZ0uum2c92EsenEzSklOUXTDWDKcZdRmPYGAYaIkmmdCqCcYEEbyuqc51sYSYQY1CFsFWazgYnWHj03rVvSFTlIS5mDbgwl+5vVOW7WxT1C7R9tmWKsQy8xW4xsNW9Yn8PlAiLZ95YjEBuXSt+1iS6r7B0jNjXkcNKQSFbFvz6TmZRSFQp+mvNqYvlyME2PysEEDOxjjLjdGXlq+4ZGb2iTocZ8vewSvfRB7pYEaFkTt7tjzrkBrfBPwmEE3sM/E4bZfodlPfIXLuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 19:08:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:08:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add i.MX94 support
Date: Fri,  7 Mar 2025 14:08:15 -0500
Message-Id: <20250307190816.2971810-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: e888a074-7dcf-47ce-0a71-08dd5dab717e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gciw4l8rZLJavIdJZDvpbab4ScNhRy0/wxGvFDyyruEF/FZ8XCYqNSNZHhAe?=
 =?us-ascii?Q?FnTMFVE0CMnvObCzwzz48wEg+ko6O5mzzzagtIye3TjV5nwdqyMASCTxiWp9?=
 =?us-ascii?Q?R6w4upL+LCUmhFSZPuv2ZYa5a2l9I/gQOkrmC8GpvCd5IFlet9vCjmAm3OCv?=
 =?us-ascii?Q?sTf8l6uXaOkyE62IeuW/1EOXdrjP2EATcMVXMcYDpmv9/PR7tOc3Kycfclj+?=
 =?us-ascii?Q?L35WnceVxtLFwIx4Nozqpm5+kAAsi9w9KhKnI9+XaEhKheulAI/tqWooAjhx?=
 =?us-ascii?Q?5J8C22APVgapvRB6V76wUuM4jq8YFQnNzQGqWwlcwu9PmRyRC3AshLRBGfAg?=
 =?us-ascii?Q?DrWTq+eXZ6ITy4n/QUcoALNTjN8Hs/GhLFmUIlc9wMz4Yw8ubU6dQUjiafOC?=
 =?us-ascii?Q?VgnIDu0PS/4IU6duzk3cGpdJv6IFgYfqYsVQ19wLfbYbeiuuq3MVTe/O8VhH?=
 =?us-ascii?Q?2nHgxquT+vBqqjQElyKCc2S6o+qT3mK5yrofqPHEF2cnhVOTYjcfUO+9Klkb?=
 =?us-ascii?Q?zgUr7rNWleeC6O+/XrZcSGOH/QgBT+ApWTj6TLiVsfeX35I5hhITG1WTLAcR?=
 =?us-ascii?Q?aAzaepw669cyitNBWxSEsuG7HVTA59+TIdUtS5/QoQFlwKZ9YT2039Sq+49U?=
 =?us-ascii?Q?8uFzTfanrJ/tbSe6jxbM4MRbsz2McEofVbBiduCaNxv6fFTLFOjMy7WtQkn2?=
 =?us-ascii?Q?z5K5O9bPJPXDbC/Ba7QOwZppKKE92SlNTo1zRCQJ7KFoeHiRP5hyiORRmoTn?=
 =?us-ascii?Q?teER2Dnpl2IeoMFk4K8aRZvm8VpWn0683y+oyaEoy1EQ7PJPLreSgeWnzxXY?=
 =?us-ascii?Q?RC02itn9SD5tOOhO7mfecd9sYoIwaNvVAMLDZZznRvy1BpsbEiV557ktTiV1?=
 =?us-ascii?Q?E1iCljqnN2crfTetHDXQCth9UyIsLyOYVXHGYQ69+2bKmiYjuTBZQgDH9YvJ?=
 =?us-ascii?Q?bjxJAcMMQV0hqoUhaUuPjxDNy2YBneSco+iHrVt3cO/STvd45riI69zU9iRx?=
 =?us-ascii?Q?97DEha9eIrj8a6W1TdEdvDY9CRlW5XpzaOHrLWRuu3ndX/+Z7d1xfrUWI9Dt?=
 =?us-ascii?Q?+tSsAnhqlU8HAdnG0KLQswkidpEDHJk29vHNg5dvZ9Lu3WxcL5u20ktJikNS?=
 =?us-ascii?Q?q66b45PvRkJGcov5udhxAPAbwhC41h/PXR67uK1F2uc7x1KP6MVvtOTNcWFm?=
 =?us-ascii?Q?NbOXhYYp9Cvi7Fn9RZ6dUS88SluSPuChx+bMZSB68NVJ4C3vOiLmds3Hh78z?=
 =?us-ascii?Q?GcP4DZHrPoSvAz4HvYPjwZQy1U7+G01XH0KpcXA4yghq0WRRbzzimQ22W3yF?=
 =?us-ascii?Q?t+ahwFBQJcJDwQPesvFtB+HSFGtDKWT8MbWJTMoE6u12iaPoyVPNXeCU7Oir?=
 =?us-ascii?Q?xi9BkgX0JtY6au+XSBItVOG1GqRqTBy9Vs4A29vTCB4XkjdWgXXl8BTwBsRo?=
 =?us-ascii?Q?/94DYUCOZ6Ewz74pC5RTJFxbbGcXyPQF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZXcX7+Ih3k/bx8y2NSa5a1Ogz8HNaifK4pmghfaU2JST12iGYc5rTfMCN2L?=
 =?us-ascii?Q?wjXnelODUoNavLhbvhhfngPzZ4hyU1Ca0IGfQypQed2R5iIujUd13gAAmIec?=
 =?us-ascii?Q?OrUlEx04sIde7R5CLgKhh+fpxwZoWDBl+Q7VD7is4lLqmrl2MqM/0u24gEF3?=
 =?us-ascii?Q?T0rAYNLEnRqXHPzXLhlT6vVS2VJeVd1xXFAcsx7oZzBMuIDBLLY9xafKekK/?=
 =?us-ascii?Q?9mQb060ATaV0VqiVCmfNRul5JtOnN54oWDRgUdyYVgy35CyEzGtncE35N7ad?=
 =?us-ascii?Q?4Gth/KT5mvxDXuK6YmnNA/HC0rCwkKiIXT44Nnfb1FNc/iGQCnK1eH+9BkMk?=
 =?us-ascii?Q?8jq6Oj/Ej/6blJm6ZmLhsAjSHxosGbBwqrOFgOM0jfhErd6R8TGriSFXq94K?=
 =?us-ascii?Q?U786wLVgqXWRo+cQBIuLUtlvRrnCHmmhgBS+X+KSjItlMsNQPKPidQJi1b1Z?=
 =?us-ascii?Q?4s3zTVv0+PJaKDGrmv66gH/c0ooYtkGueHzP5z9oLC0KgoZcg3MwIcvfojGn?=
 =?us-ascii?Q?YJD2yRYb1VCSzPQBtfZm0EliJRQmYcBGIzq8O6D5Ue8G+7opBNJkjSsL4b1T?=
 =?us-ascii?Q?+LCVE9BdQ04WQHUBZFRg496yohhWu7pS8pwpPPUPEqOo9xAr09uuYBSRQj5e?=
 =?us-ascii?Q?F9vZe0f5BN9otriIJp5oybS2pwNfh+9FGEd2Urb7m60C4E0tzwC7r1QYQjof?=
 =?us-ascii?Q?mwI0P7wsGOfRgOO7v/GnRMGwOuOLeQ47v1tSpjak3hunTQEWfgcnY29Zm1cI?=
 =?us-ascii?Q?3jEtpTWqy7a8O+V2yE01UwCluM3PP8gpASOq5ClFAHLTZEtbyqO3/Toe9m6m?=
 =?us-ascii?Q?TBUzNRPtmWUBr2fl5ouERZUj/15uFSNvVH9KXZnODfhY3Ja9DMiKGneJPW4O?=
 =?us-ascii?Q?ZSuzLvs1DfLJwPoeoT05Arg83m/pN6+OLcn6n1U2oQbNbQeUehUWsskFZTDH?=
 =?us-ascii?Q?a0aofzVpyZhiLA+UCXXToxaZ5Z2Lama1YBs7UcnTtAzCDRoI6TJP4DJEagaR?=
 =?us-ascii?Q?4REC7q+hVfEorLsWaFD7WJc67umO/T8Vc/vqQkg3HzfaRdQG9RyoTl4onQIf?=
 =?us-ascii?Q?C8sqn7K7dZbBC/SZe4kNKWwCD8YJ3zugwA1RV8FCYSR+C25Fhcs++T2E/LtG?=
 =?us-ascii?Q?iwmRHtHaCQEGFsyN2L9gcyLclr+2ZP0pbzigdVmwSiet267MW6cJQScxjHpC?=
 =?us-ascii?Q?lkuFeiWq6PJqlLHN1iLiY9EtSYAuvnY0fsMfwLw34kk9ms0m/jiyKf1c6jap?=
 =?us-ascii?Q?sdBPjMagKEPCq8NPZqiWstQ1dQ8ZLUbIrx7oCL658fauVSrFM1Q6Ea+b8fGc?=
 =?us-ascii?Q?MI8MvVWY3BGLgiK3IEFCo0nOEW6LikzlYzoZQq2Fc0HQLRg47v18Tmiuf3xa?=
 =?us-ascii?Q?w1XnbrZCC5ObRCE7v3c/pi5CeaJAQ4mQXsDaAqtLM3jCcnpfH3fyReHWCxM1?=
 =?us-ascii?Q?yIskJoRUIlf/FixfNfJbTnsgH66MvZ/Y+/jg3PSFHDu/1Ck5qCQS0eGppuLb?=
 =?us-ascii?Q?KUN0Bb7C1ZHvMUlqOZAexEcRfNRjmsI15VaQpdQ3VYHA2VKIb64GKrb1oRRW?=
 =?us-ascii?Q?JBgY8gMZTCZ37WPBQl0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e888a074-7dcf-47ce-0a71-08dd5dab717e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:08:28.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1+fk9liPx4es/QDtNahHVAhgBSIdJ7lK0/lIoIikpT/jxSMUKe8HBbVOT8Ca83TyVx+B07JPq5hedYgdT95Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

Add compatible string "fsl,imx94-flexcan" for the i.MX94 chip, which is
backward compatible with i.MX95. Set it to fall back to
"fsl,imx95-flexcan".

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- add Conor Dooley's tag
- fix typo "fall back to fsl,imx94-flexcan", should be fallback to
fsl,imx95-flexcan
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 73252fe56fe6c..560da9fa1ea15 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -45,6 +45,10 @@ properties:
           - enum:
               - nxp,s32g3-flexcan
           - const: nxp,s32g2-flexcan
+      - items:
+          - enum:
+              - fsl,imx94-flexcan
+          - const: fsl,imx95-flexcan
 
   reg:
     maxItems: 1
-- 
2.34.1


