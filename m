Return-Path: <linux-can+bounces-3016-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBF8A5528E
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D11762BD
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56E25B664;
	Thu,  6 Mar 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlTcU1yN"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D8204C27;
	Thu,  6 Mar 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281049; cv=fail; b=EpiqCsOuuX1DIGYzT9RDkoxIy9eJuaOJCcusV68UNS+snPnIBqKazEFXU5pbIi5buTx/12lHHotkToEkMwO2Yh2T9+5iAy+LQd0lDXnDxsdzGqE4tlb3l0L95cSSS6mlvYQzR2NZHnL2QYGS2ilie6Z6cV5PQatrfDv1w4fsC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281049; c=relaxed/simple;
	bh=h3+ybj8dWTK5FaJjrXFSkUljUfO5L8oubgflnuTPtrM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q0fD2FbY8CK6n49UADRxwnTstU16hW91EOFVWPY9Kt/vV1mB4dU5CNjOUbW2mZnVZvOMuS9RriupMu5+VndWnN6vvCi3F6MXfAVSLq0ZpG+cWI5uZju7jRrOb8qusUL5qitejjHJG6MOHgNJMM82MtxMpjXjHMMWMruGQigIWAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LlTcU1yN; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNzQmfP6vUadDZuPBm1C1bMZZTtI2zEvVkVMtjj2NRFjReX6fKbgop7OEfKPrJOIl06+rkfkGwmU5VXYyfATeNNlrP7bJhe/N1fCpfseIu1Fe5isL9L5qnqQrAQd2CzjKamLYd8FL6nh4WUFyc/ElxxxBVERkzGhpSLkZjUpK53rfUWgMhJTcs3rSKpsqk6xL2nFDoFRdMf5GGva6UZqA2zCuSBlXUVWpMFPkIFazNfJ2NuzvhCgSwI8HydCiy8SvU5Q7EkYYw5hmf6NeHglNv6d3h16MVvyjVyJMYqlUXO7r7YnRMI9/I9/b3zbxxUl9fDN6F6rzbE6bX7hRAC8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56b0qvSvq4OytZvoHvtfEoeuMSIolIk1zCjkT+HX0F4=;
 b=M5txEa5fwgXmCuPA2O4rFRapx+ZwSlIMy6EZyxhCg19lJKU33CQ3foI23rmk20lUDtmBuWaeLhLq8+JT92+decpvjIT+vqeRXue7GW1SX9c/9s2IGsr+40ZezUlCzpgPghHDpLeYlI2IhxInXIINgMxQkHC2Vhmw9i6M1Q2V13kmaKZwTtNDx9gVqgJJShkfreO27/MlNx3GFyJBlb6EjKvzvL6rSewYrA7yzjFnFsMoQ9mmQB464sYCPS0E29I/w+MlIGpahSICsD9yWfDQDQnwCoVpSb/6m8/9iktM+khEJEtInYxWCoGPPYvBF5570ruInKjyd4gT0ZhGAmN2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56b0qvSvq4OytZvoHvtfEoeuMSIolIk1zCjkT+HX0F4=;
 b=LlTcU1yNwS0EJgysXSOs+ULWkiNVOmD3y01V8UPjpxyQkrbP/ft7MEErM25R9l+EQkFLFy+pVqgk4r/X4zmL1AESjDPr99bXCZSlT9JQZlQCJYbWIkFTdpmJghwcu2ZNWlJ0V5wQmZ0mt1os+92SLbWnwGhZ3UsDlyWbtvQCWZHS0HJATdwkIyYT/wJqNxICsYHp5n4rjVV7nWPjgASn2i4sbLQQkJHm2P6ik7wodpc35+LyUIbtZ9ABCFa7NJlKaUmRaGF/P2a6VbDyLRIjVQ7Z9Hr6VnRcUMLBhjCF97kiBo+hKlIVHmZNAzxAfCa2SgVOIlimkGnz0Y0WjNWZZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 17:10:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:10:45 +0000
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
Subject: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX94 support
Date: Thu,  6 Mar 2025 12:10:32 -0500
Message-Id: <20250306171032.243954-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe0ea1b-08ae-4f24-9c28-08dd5cd1d530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jc/JslpGaHh+WWdRwsme6eWyvtfSF6lwa9kBC93MWKQPlnLuMP1175Pk+Pjo?=
 =?us-ascii?Q?MQfXBjSfnp6pcJG/ut55w9/khgkziLkqtKuS6I1itNlOknmHxgeJaEw5bun2?=
 =?us-ascii?Q?TaqyAbpzQs20cOITysIBuCVjHCUiBlondfs+K3z0CuULsWckxHLqLcn1feSj?=
 =?us-ascii?Q?ru83aKgA3jr+E33kI7NPNG/51hyEgOr1c97XVW4fSjtBqdrvkgwG8nkqOpm7?=
 =?us-ascii?Q?8wvH6LWUp0S7Nfb6p0Zvec2RQLp9dPGUWG32ipFgqpS+d395x18otGHSbBR9?=
 =?us-ascii?Q?DC6Uog3OtjsofwNGKAiKgSvHTtQET+eQY+QVwxAacXY6lLLU8sG7+SqAocs0?=
 =?us-ascii?Q?Y0GMa2MJKdm/dwXU8I4moD60XYiGBlxfOz+yFNLiW4DP1q8YXXqc5dCd9xzy?=
 =?us-ascii?Q?RoCkKH1IUn00MPgJRzNKepJqsfNvCG37ns7JnDdqCycrLw+O719i2obZFkHa?=
 =?us-ascii?Q?wS9I+ID1+wPr9Qoo89xX/xPNR03uSCw5iV8O+VWIihL5elIwc+l+Hm9Zi9i2?=
 =?us-ascii?Q?xc0HLwWgWwSHNRX3hr7wOWZ9pM+I9IuVlUTSLtd8Bv0luDJs+ivuzdPcZCmJ?=
 =?us-ascii?Q?RvfsFBwjY7lQ7lxj7jOUs7zCNwXbQOvDSydCT8vfQkW7doRJYSo//fhyZ+MG?=
 =?us-ascii?Q?szd8PcV3qWDXdC8hJ7AFEZ1n2MX2XqfD0YGpa6FukM3lYoieApCHnixGUwIq?=
 =?us-ascii?Q?11DYx/khDEbXTdEkCtAPn6N7EQYlWEA3SPiwFVE4GPQoYnrzAnyEX7m4LWg7?=
 =?us-ascii?Q?kEFal74XA5OMvLow8d0fgSpIwkEcGUM3uolgOOODdC6TAen3SxWl15cX6ukd?=
 =?us-ascii?Q?Mp+YUfsTofcyksC8GJKxkrlU18uO59XVuBTIsf8TIjSw6k1BMSZGsZLRbszG?=
 =?us-ascii?Q?B2QITYKcUQ8/rL7JNQ9e4wM3pySrh7t2JVP4hNQlIQpiU0iiuUBPaa01hcDo?=
 =?us-ascii?Q?uP85C8ECyfOKGLpMd8xWNIc4vOsC29s/OznRpVKHT/XCrGS0MWa3jIHGBv64?=
 =?us-ascii?Q?Fwdkk4Nd5weXqXCZ9QIASPLhVmwXuHnVLhV9z1jxpf6B5rWrSfJrB0nhItxV?=
 =?us-ascii?Q?xww8X4w2NSNj5RO1AvxrKoXxZhGmNL/zM3NSkuAQSh0Opy0otjuGxnrsBtid?=
 =?us-ascii?Q?XlaEHs100sq6F7MVWOhtxW4hNHERUDg/JaJ9nwDLZsP7LJ8c7uRAP05KEdNz?=
 =?us-ascii?Q?gYTyKEq2x1ZX0clRNVNwZnXZjP/JlF5cRThdzvurje7Qm6UhQQ0is091bxQw?=
 =?us-ascii?Q?1mVXP8Rn4amADo1st7D7sljv0RzabvusfTqV52/qhYAvMOyvR7Ner31ZwHhp?=
 =?us-ascii?Q?S7edlTDSqTk1iWjFRIxwgI/MOTLqtyl7K3svi6K1MyD095j+4TXQIvUn4oTZ?=
 =?us-ascii?Q?XfU7sYBTLh8brq1jFoPK17uJhKJCKtcczwSYLsJuXoXFHmx5ZRxsq9voWWHK?=
 =?us-ascii?Q?rOmE8zGBEZuB75Q0uKTUHNTGHXDt+DkL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSVj5+68TMuOenP3No0+A3bRYXUNAEZtzUOnDCRkPJgOJEalbNaETtfgHu1v?=
 =?us-ascii?Q?jV3l06dOVBbeci0l7FqcXD7FzU6yRixD/1ZReBH0eiAJCyA5pRlzZzEkGdyc?=
 =?us-ascii?Q?mXMyJx0+EvZPRozODFNNdkbMkbujm/zpN38yav7M8dlmOFNu5PmVXIuAuopa?=
 =?us-ascii?Q?tuRmLhv/QrJGZI4LaFnlbllOv2xgCgh8soXonJtcFYekifQC5de1DVauoe8/?=
 =?us-ascii?Q?sxAQpQaV+4cNiKW9W2jCkZ1NdG1hKVqLJ2fnZCTNR5gXVX73dMjRrGXL1Gx8?=
 =?us-ascii?Q?4gyJpEwnKl93NqI7W405xq2qBaFGZLanyfX3XSynBCNTPRfFM0FKizZGW06S?=
 =?us-ascii?Q?xZ0qIQsiMcTsrzBE3L/7Mw+w9lkiQg2fecMXuWBdjZhVyyFNJJBcFzzvrwEm?=
 =?us-ascii?Q?/98RCP0mX89Zv7+nj2FTeTT4Dnhq84LWG4cMWymzZlAoeAS7WLQSyx0t+CUi?=
 =?us-ascii?Q?80lTTlCnKfYXCH1adInuJ44Tnxz1k5TaO1yZ1jnVrwQMs23twltNVyedXAcd?=
 =?us-ascii?Q?0Fb15utFjE+qi9pE8v4vOxN0H7oUbPNfJ0EOtbcp3rOgLGuxZOn34QO3WXOL?=
 =?us-ascii?Q?BtbWbECRTFI/LT1sz9mJ+dwtOZP8YNvU0zEP6KPrpZoGCgnINtRgHdKNsWfH?=
 =?us-ascii?Q?yQmidEjSeAmgn7U3SgZUg1/Kyn60a/1YIAwsqTC2rV2qw08nBqYAznhEihx6?=
 =?us-ascii?Q?FyHxH8MZxIUWHfgL98XN7sTEqv11hCRoMDjpwvC7ctJewAOHRHGgV85icNre?=
 =?us-ascii?Q?wELWXI+zzspDEiYVyzIiGRHjHsgip72Mv69VqXHY+JgJvG7TByeAm0gteTCg?=
 =?us-ascii?Q?s5X4UzwQJ3olr6Bq63ucVlqawas74vXkAsu2xai1xL8Amf+u8ObCGBmkQgE7?=
 =?us-ascii?Q?LCGiKLhCWiAI1oBniV+5YbokyaSj8W2H+jxMAR8huEqoV9FRQ7pnSRF1lRzV?=
 =?us-ascii?Q?Xz1a/6ge3us8cpK/bzuJY7AhaljlXPUkDILqVXqIyjMWlQyWh4JGsWZt8eCu?=
 =?us-ascii?Q?dxALxAQMuVIzYZ6NW0SjJt97AcGQKvUDYr8ysXjRVvxqzwP9aaHdkhwX0dj9?=
 =?us-ascii?Q?Er1DmYLDPtuTa4i6pHcPxWAnSxpwMFntVOMOUyalakqPBSGcWuBfZbJ9JXKy?=
 =?us-ascii?Q?Whbsf5g7UTH7HVrmGXWCr4YHyD8MPE322WfKMolcKYKWp4fx7SKj30ZpRaw5?=
 =?us-ascii?Q?rxAMzqW34BUNTQOCVuki5so2vnHeT1Lr0xPcdcioig5wsRItPWDkktxd75JX?=
 =?us-ascii?Q?paPuJmimYIO+vDPofhaAzLprANknkIh5H/B2um2GY3jK1yi28DVJb68DDwdS?=
 =?us-ascii?Q?ToD/naD7aBY7p1w526ZvcgHxY7IhL6g+psbasWagJ218Wdy6esNNn/Q5McKb?=
 =?us-ascii?Q?P380uypnWfzvfZeoSNIfTF0+MY3Jj8rC60KiUsrjA/Fb5nWLZ0kO1f4dGCPY?=
 =?us-ascii?Q?jPgu2+guaXYO28Aebumyr5UzxmISn3a1ERLtQqcjO/tLsrbrzwc4RW//8MUT?=
 =?us-ascii?Q?1ME4QIEqrpfKUA1jVsBvxyCv8pTbqL8eyR/mCvmZtzg3PX0keb3cs4rBltWJ?=
 =?us-ascii?Q?OKLpZhfIh6uKpz7HcLgfvt9peadlVUVL5kl+Q4ZT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe0ea1b-08ae-4f24-9c28-08dd5cd1d530
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:10:45.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh0oT3kbEVfOTG8qJ8OFIi7McVaNNcrAsOmrBF1yrRjyhrtfAesO3FBDbqtzqYM8xG3pt/Nbe5RPWFsxKRxGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306

Add compatible string "fsl,imx94-flexcan" for the i.MX94 chip, which is
backward compatible with i.MX95. Set it to fall back to
"fsl,imx94-flexcan".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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


