Return-Path: <linux-can+bounces-7570-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFXeL3iK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7570-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706A4F2BA0
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D00F43016793
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF437C0E1;
	Fri,  8 May 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="RJ0m/sVp"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021092.outbound.protection.outlook.com [52.101.76.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6537B407;
	Fri,  8 May 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223712; cv=fail; b=Ziz5HappiOi4Kh8MU9+Dc8LX6Y/9fLSu4SMIaDlIVEcTaiTd+qkufqIWWdT6zLYhySplpkbamzNMq2JKCRIvY8Tv/7hyBaOeZr9zH+fftqadOABAboDJTScUnIo31yLZbzCPY65rsfBj5s2Rp/W+AaUkyVR/l99mrsVK8bI7SCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223712; c=relaxed/simple;
	bh=vPFbemLrkYcl7/RXUPVEuGX/n2XsyzKHCggm8oMnfbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NpirDk1QqWMSkjcmCHkhVR2LDB1Img9sqIdEnP19QFCm2bCCdwxatiwJo5dM7m1LFcFPNl3g4zox/7lCEZaoL4hiLDchUw96k3ePL/tcI6rUbB9+ziC8lxsrV+rpGVRH7zy1/crHccnI/u7TMfZk9L/CZrak4McoG60VjxxTDJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=RJ0m/sVp; arc=fail smtp.client-ip=52.101.76.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUH2kjzLXRUA1U38G2RlgumFUSisV4dJ0lyjnlfw4jupJBr6b7xpHIaS5tysiGrt0E56AWfe4f79zVujbmngnqKc86rgPYwdm/UA5fsqou2fTNyP0+DEAv1jXVU6fCpSNa0MK42ukTX8pi+H9qf22JxEKSeUXvPO9zzrd8tfP3nneSzC/l+lVqGKq/HWaht23jDFPVNRHmh4RBIX6g9L9Tvt6PrUTNuJiiDyeTdFbrkprADWM4oOUMlRknBY4N//QFnTdzAmF3Otv7h4Js7R7hb5XJsBAxp4Ypzs62rzWXamIC8QA0ay7nm5NxVSi1ZGihUuHEiRl/atOAWLBWlVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TTP4gzRqMVGkRzvcxjC1YZWMrs55xA+qmg7LfUvTAQ=;
 b=iCsEG5ejHcqdOyS1Yqig9AEbchcpKGlSu99AHsdboAylpwyQit4vsjbReqk41QEeYTPljrowMiADlJ7i5Ud+AavjMfFMYznMk5pfzfKdGJ6XtmoBxJ3UltqSnrKh3t2o0aRjS+zY2ewZutN/n/svsn/LpB1ax/RRpcX4m6NqXhVqG5lQjEUspCmEU4QRxm/Y6q+ujnEsad5qN0rS26zJkT0hzSQviVcO0wPbW3n/6HHfOjvvcDW6LOEppOdWMyuUrsDcNSu/o0bgMHc2/n3OSZhwTwN00TIv6QFFTJmDtBqzBMQftS+FSPhPWdy+hmuJ/cGvh93X/1NnXwL1PlAd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TTP4gzRqMVGkRzvcxjC1YZWMrs55xA+qmg7LfUvTAQ=;
 b=RJ0m/sVp0RR+N8G/1jomrrFIPzi68MCrGgFOukPwa8eRkCerduFYSDKOPv/VEmM0XHHdYEU/Kr2QVccewouRpXDqf4HUQNuzT9W+n7WO1ZsegcYec7EKZhbCExllDTLXjTmoak4QVn8Frmte4a9F+A2NZMWZN6OS9/Tuae2d3oM8VDvKiIsNjrj/JOm1j5dIyp6SfaBK4K2Us9DatIt1G9UNymi63EM8bGcRty3qFTanPvUUPIumTkycqt+UHWraPYe4x51+UVoiur/YEZr6qTphkuvVS4wb0nyvFaghfmpwZSizyGjRkPbGXIyfLKHWRFwZ8wyB/FABq85a6IszDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:35 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:35 +0000
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
Subject: [PATCH v7 08/15] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Fri,  8 May 2026 09:01:14 +0200
Message-ID: <20260508070121.6918-9-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: c250866d-dd73-41e6-62e9-08deaccfa4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eaXJMeEStsl/wIrV8mVle+pUtMR8ap1NhhS3HQBCfjjHfiIz08KhU8D//S8EyKrG64fvBu5w2LsFOaGCl3VcHCeq/bUSWlv4rmTq7JDBhTso2/Zi1AoyNh//AGZ3zSLYGmS5I3q5HKjaq+491U792zBeFYYax4uPmGaFRgIrv6oBX0BjHsicGQVN6eDPRWgEy6BqWdq7/5bOp1C+9pK6O3/jN5h7qfQ11JeH2HmN6F9VyVj3rfpNa6lDjl6eSp6EEHR/IrLZ7NKnNApS/7lDzyFZ6YfX987Jw8FEMKXEP2pHa3G5KTn2fOSCDXTuDrlHLrck5u+UlvGaq9TQfzrq21LFj3x4suKWb2r5+FDjd6EMyTOQjmAyrC/UjzJyke6AVAiX9PiMxZ1apGnuImDiILl1KEyCr7cyWufpgU1EDm5gP5YDXRb28/+77Q8OacQ3+PqEBvksRqiUQd4+eCkGTiEFNUvnDhzN2BUUDH07KIu0/3HhbvGR4Glw0JpXO6ZMxRHJa2+sW85h8Umt2DgviwycK2g07gqrrx8rrQkkXio9kS08qXPZwXkmCBRJRGjd92SHfBN8/NbukfTfGthV331of33SShNqpErv09yiygkIGsjdE9b/hHjiW5b+XRqv8IkOTRX2vTcUn5jNFpMzjtd5qAh3ybYeNsjRO8T7NTC2b92+rbPfcPkKhzD0clloyzeWdwlZdMcJqoGKKSka/LfCRJVOXzTi4oX5urq5RBDO8ra2ad2MZZHe04FnVsXZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fEswKXiIeIcoRoDNyb2WBXcDcanJoLkfpoBKJkYaTzU2CjnxueBDDoOBZetx?=
 =?us-ascii?Q?2BXq/tB1ShJ4JRzNywdYvac0l75RFICeTVr9AOwqK+NEd+sh0zwBTULhRSTR?=
 =?us-ascii?Q?Ck1smmJBUrLQIeW2qnkYzX5PfGd67cdwOWTjabyz+baWgUuVaWBpjWu4KZU1?=
 =?us-ascii?Q?I+I3UVVBrcFhLZjHDt3dSJAYO+1kWUPyRbv8feXjJ+eC1zQIp2VkdaF1fNMb?=
 =?us-ascii?Q?mNoFWxRZlfu8fyqju3GsPooWxaFjCHyqaWLWea38r8bV9POABV9ldDu/Vhs7?=
 =?us-ascii?Q?FYlnoCoBL4ZSh4CUXZ0lBOpQj2amr4fVjEBXLXkVodSB8IDajtR24KtwXR3O?=
 =?us-ascii?Q?yGChhRWMwzZ/GP1rkVmXY4VFbVo0SV7R33XU4rlKmnGG1rCkgqXhiyJTbONZ?=
 =?us-ascii?Q?A2r+jueD9yFE3zFkEC9YYIDPJAyT3XQGwaQvSAB1RhveT1Q23kmjgzx3wkNk?=
 =?us-ascii?Q?42WBriY8PLVjHn3KESo3p1fmWyHye3fRsYOlX9CIu5/lUdTburLNSkplZhbe?=
 =?us-ascii?Q?DI4jtXruHL5yFEjirzSQvyLOyOejzT+AcEPvHwTA+F/4bjWBSj/OpwDtffs7?=
 =?us-ascii?Q?zsq7v7rFOerk/K6fLZTPnFbKchzbHlX6L1N91FHALakQPxgXKc2jOYj6OqYN?=
 =?us-ascii?Q?bJBfqls7AFSYCq6LGcW147VRENAVa6AGlkV1OvX4en7eV3L2V9Pu7mdiQRC1?=
 =?us-ascii?Q?Oc1lUfh72j0UuVneWCpZ+UDMtdRcqExrPnfE5FNKQMkCsLjwRez7iGuY35RN?=
 =?us-ascii?Q?7nbvM5k5pmxEe5usx/3uAmL9rFm/wqu3Pedj/FAAFmES3InfHNvsf7hF7Tm2?=
 =?us-ascii?Q?dwAzgExx0aR4ZA/9zk/pgUXTIXl/N2rxFm0FVX6Uq1XjJ5nlfXNIqVKygVdf?=
 =?us-ascii?Q?4u/2Xn6iJZySToo33tVL3De05sR1rXSupdB3fO0QxJJLNOsysBlNz3Aq9VtD?=
 =?us-ascii?Q?N6cPs3lMgNciOsG2jVEmgxgQsoX8dRN1qP4+s0fPOZ8WgUc7SmpXfCtpp9W4?=
 =?us-ascii?Q?4FqY9eO97ZugtKM44bGyeI31dsMAVIXoQY+N2x6SlqnVnwsRf8NJ1Q2GpWBe?=
 =?us-ascii?Q?BiskbUJ9xcVmXCuzkw1m8VBZaiiGcLkBYHWfOAQ5rrRJssBh20kQSoa937c+?=
 =?us-ascii?Q?MibKODjGX8NIJa1kW+hl+66qgnoBFChCy9KVWpPipfWEQIuuciI31NlayU9u?=
 =?us-ascii?Q?uKsliuyWaoxFbmQ/Tu+8VH3M9XQxGpmReMRZSbA5nQ+Om9oJCiB1PEawFlWZ?=
 =?us-ascii?Q?YdZOG3D1XQHcXI4bCxw7Q9KTw37yeQ/fxvx7iKUpjuIkqbKKfnaJ9dHEv6Wk?=
 =?us-ascii?Q?hwNFjoGcwai2mA7Nkm0IcPPeELxDz0Qeed0uhShb1XHPRgBAiQ3VIZ8AJeFr?=
 =?us-ascii?Q?9VDnp3JapifNFI9iuTMJh6Z1SruoACmHwk35U/7PhLgT25IcUM5RxZgb+k3q?=
 =?us-ascii?Q?++LfbuzfGTc/ieNjEZR9wn5msMriyEKFQL9qEcDb35+UiVW3cKWU4F5QMC8P?=
 =?us-ascii?Q?E9f/fngu/IhN1z7lruPefflXy8OR05fStHfEzB2p9vZmaZXigitJX6Mayn6n?=
 =?us-ascii?Q?4hJVVL85PzRb3hYaQYkBU9y6HK3BxzeBa6OypWmuLWNK6Je/xKtztS3tRI7W?=
 =?us-ascii?Q?oj3CCLPpBT1YsRpKp/rdRCuCXAoZE5rLmWXVFyOUMd+VUpIdaf8uy48226Rk?=
 =?us-ascii?Q?vrmydPN+wTn78pkT4+Y/0M1yMAVHmfxWB7WtHPY7bkcjlsKZcq+/oeG8C0ej?=
 =?us-ascii?Q?k+ALdU5ydy+Ubw9jLWw2e3PFp0ZTXJQ=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c250866d-dd73-41e6-62e9-08deaccfa4c6
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:35.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayoNchOEfqKn3QaE+it+/BCWF092W/XXHpLzamxSib5l4Xy681QvcPaRzMwVNzD75ZNO1YAFGPZzUL50qKYo4Lk6OpL6oLjZk8IOBQxDP+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 6706A4F2BA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7570-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Sets the DMA mask for GRCAN and GRCANFD devices to 32-bit.
Setting the DMA mask and coherent DMA mask to 32-bit ensures proper
memory addressing during DMA operations

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index c9175a6a013f..6e0a393785e8 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1746,6 +1746,13 @@ static int grcan_probe(struct platform_device *ofdev)
 		goto exit_error;
 	}
 
+	/* On 64-bit systems.. GRCAN and GRCANFD can only address 32-bit */
+	err = dma_set_mask_and_coherent(&ofdev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "No usable DMA configuration.\n");
+		goto exit_error;
+	}
+
 	irq = irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
 	if (!irq) {
 		dev_err(&ofdev->dev, "no irq found\n");
-- 
2.51.0


