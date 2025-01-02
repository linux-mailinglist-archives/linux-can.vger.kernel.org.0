Return-Path: <linux-can+bounces-2522-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31969FFEF4
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C416D1883A82
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76D185B48;
	Thu,  2 Jan 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="XQvMvscT"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2110.outbound.protection.outlook.com [40.107.21.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAD7E782
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844312; cv=fail; b=IB+5vNkz9kjG3dYwiRYD58hbs4M+UD7lzQKmWow0vrIYGxDuQVC51vHn+ODInlhVIJUThbZO+zQVbqUUX/FbxgP8WfAmC6FQg4fynaH78ksh2hobhcbwGmHJWv3ZfwHY0jceCNQY6DiWuHzNymCIlVwr82VmsIgK5SzIy2wS+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844312; c=relaxed/simple;
	bh=9PnKRxteWd+7eKFNknWE93B66nChjgpXxGIj7oq2G9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LztWvxyrtv+D/WnpwL43U/AM9hXbQdAgU1nqO2Wt1P2goNXC+dBQ5XJfoe8ndGlzLMEfddVTZtiTPHMVmIHnBwh9nvwrtnaAeXQ03Nd4aUMYe5s1sqAvNdVnxdT95sSd1tAk2O7T38L2G/GfhT0WV5psYUCkP6CmlAE+sz1A3W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=XQvMvscT; arc=fail smtp.client-ip=40.107.21.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8P8kI0taeZ0LBs/TWQiXRgZGh3gOdwtgaLgltaMTIIff6usCxrU5OQR1ChnDaJJofVVIEIQJ8rwCZg6Ncawp99YjQCYmTwdS2OblXAPCCO5cj+dzFvsCrcTbqV9TiXn6Q2FYV6X3q1U0dv96lGFIjKchzVcBrUIZ8cG6HKcYz+YVDG8W7jeFnRbnnWACUq84JzeIxub6Cr9AcWg+tuSiK+bMguOZYw3Olivi/9C/ccWMOQLJzrnt0Wz4kkgJbP2P0RA2P15N2hz1l1PGfVRdWHAEkbfE7QZohMdd7DavYKrbh8O+PkCDrshXSHK9Lktv2uDKSIkhpO7IMbgOK3kYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/kWbnZ3WWiIhCZgmC+ltGmmOElsWIW2msa0xFZ+aQo=;
 b=GAvX1X1kBqZ3ZykCifUWBh03pLWIUoYEfPQVV6hCEG11TnTxjJbdDu7CDHQfCm4HtyDOdbYfRAqY+ygczZQQDND/vq369C7NIyjZB2PBzJZNzsFyNRyCywK4kwxhSmAbrV7DKBLlnvl91cs5QXgBIWzVOtRRfvDSjYCEJJQ3zgRvmha9QqEQB+pywI/Gx4fRopL8RDJFxNh/xMPjA5+W/n4WA7Q6rtzQ9XT2lD/8yDRfXZMLeQXQmuIX3d9uJbdQkw44GXIg8XqmRzussHjf88GkNY6YWf3/SClDZc/dKYTguqj885f/3cC1NEWsChORq9XfSyCRUe2pDWk+ZPNXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/kWbnZ3WWiIhCZgmC+ltGmmOElsWIW2msa0xFZ+aQo=;
 b=XQvMvscTiBbnpm1auFv7/paNLHhnX3DYA9l2afTE8F/17BDbicmHo9IKxELIjMPwswnyy73YU8c8IvHaPPSOeU1Ka10teADaJBvbNliE/nsUyZ/Py6Ai+cAF2qKgU2LzHFBfLtjY5hXowgm8h5dn5AFtSOyS4ky9xnKl3kAtlso=
Received: from AM0PR02CA0031.eurprd02.prod.outlook.com (2603:10a6:208:3e::44)
 by AS8PR03MB7141.eurprd03.prod.outlook.com (2603:10a6:20b:295::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:208:3e:cafe::14) by AM0PR02CA0031.outlook.office365.com
 (2603:10a6:208:3e::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 18:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:22
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 713E57C16CE;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 6D0292E8034; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 5/6] can: esd_402_pci: add request to provide a common BRP
Date: Thu,  2 Jan 2025 19:58:20 +0100
Message-Id: <20250102185821.670839-6-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250102185821.670839-1-stefan.maetje@esd.eu>
References: <20250102185821.670839-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|AS8PR03MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e04555-f145-4b27-93b6-08dd2b5f6e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckZiY24vQkQzZjV0WUFGSzhmUnhRbHkyMCtsdlZaRWlpd21aS2ozZ1FFMDhr?=
 =?utf-8?B?WTBDR1lRclh6NVJZMlJtU0V2R3lOcS9JUHdDQk8zaEZ1NURYd0lsTDdNYVUx?=
 =?utf-8?B?Zm80bVRWSDNFRWF2ejBjb0QzTE9NR1BuOGFWS1hQemNTM285VUxDVHZaVW1m?=
 =?utf-8?B?R1VLRlo5Zk8xTFZUWHAwZXFIUkU1UVFRU085U3pLMlptRUdSOCtMZDVCN0dj?=
 =?utf-8?B?U3RpMzZWUXJQWlFIeklVUnJlKzJpWU9CSmpYeHZZWWNyMmhvdUswcTFjVnV4?=
 =?utf-8?B?WWJSSFQwbmNBcldXSWRaRTIwbGVGZmpsbWlPM2hMc2FMZnVGbW56V01hOG84?=
 =?utf-8?B?WUUyVGh4QVByWmpqSnlTa0hhbDJiaGxDV0xIWW05dEcwT0g0UFFEZno3c2F2?=
 =?utf-8?B?RXc0U0x5RGNYVkJaV1FSaFpVVXVSeHBySSsrT0EvSkY4bGJ4YWtlRy9JU2o0?=
 =?utf-8?B?NDVZN3g2RVk0TnAvN2ZsRFBKaG1zMkFQb2NrWmxMc0Nxa0NlTnJzVVBXQ0w1?=
 =?utf-8?B?d29ldXZkTHI1SmJmclBWblZ4Q0tGRGpOYkVXdEFtUGcycmMrQ08xK0hrV1Jj?=
 =?utf-8?B?VGIvUXIrL08xS05SaitKYnJGYWNvNGd5TEliZFd5Q1ZnUU1kQlVyU1hWaVVo?=
 =?utf-8?B?a1dEcWNjUUgreDNXdk9URFhNU2V0dmtBaHBOL1dRYW1XRHUrSmlwZnVhY2dW?=
 =?utf-8?B?eDZOSFp0VGtYT3VFN2hNcmtFaVhnL3dNYlYrUHVQVzlWaGhWMFJKWDdKK2Zy?=
 =?utf-8?B?RGNnU3d0UFlOdXM0eTZRVythb2p3Tnp4M3RnempFVmQ4ZFVaYzMyc1NHakdt?=
 =?utf-8?B?RlJEWkRES1ljS2xvZGhFbkxXdFFBZHJiY2RBeTQ3R1h4NUlSVEQyaTBDbGNo?=
 =?utf-8?B?elJNZjE4Y3hvYmFlTFFCUGpGNWVCTmxidmlJWWprRmgxcXQ5UjF6MTFCUFdD?=
 =?utf-8?B?TjZaNERUZnQ1NFg3V3pPbU54VEQvTHUyeUg2VUxuTUp5UTM4MGxQaUR6dk5s?=
 =?utf-8?B?WU9PNzBOakI2dEtLbGtQclNWb3BMcHV1SWozQ0NyQlBNa0lCMVJXNldEVVJs?=
 =?utf-8?B?SzJIUDdpd3N4NmtGa3Q3Sk5IUWFvcEZhTGUvWWxBQTlybUkvRUFvcUo4M3pV?=
 =?utf-8?B?aC8vOTFtdXcwYW9PaFBMNmkrVlpyOW8vMUdFdTlwRFA3NkdmU2lMTzUrZXJr?=
 =?utf-8?B?WEExY0VuOUhuZWlWWktBS21UQXRvaDBhYkQwbG8vUzZCTEpkWGlUM2JkcTRs?=
 =?utf-8?B?OUQ4ejViVlhlVThVWE5xbjdOTFVpbDkxRE4rQldXOGRlekk2UEw1ZE92SjF6?=
 =?utf-8?B?MkIyUzltNTc5V0RDaVFVOW53ZG95aVkweTBZUGVQVUxxc21qUGRnci9NQWkx?=
 =?utf-8?B?c2xmdTIrM3EyMlNYM2dqRVhIdVFLemRMY0lSdHphekw5cWJ0cmtZb0hZSmlQ?=
 =?utf-8?B?L0IyV0l1R2tXMzN0VVozVlRCb0NhUHdOaUV2UlJCR09zblpjb01LQ0Q5aEcy?=
 =?utf-8?B?RFRCQ2FiQjlNT0d4R3FKTm80VFdqTHJTd3dnNlFxKzdvQ3VaamJDMDg3WlVn?=
 =?utf-8?B?Z1lub1EvRU81bk9LTFJuejArV2YxTGVpQytUdVVGR1krODEvM2w0T0ZrSzZY?=
 =?utf-8?B?ZC9kS2g2TjE1WWFXeCtZcFZBM05DUmlJNUNkSFp2NzF0OEhXVEhRUVc0Vnlt?=
 =?utf-8?B?UzNqS2N5VEpWdFQrcmgvUDNVeEt4b09FSU53SGR1dURRdDVEVWh6M3I2WUN0?=
 =?utf-8?B?RlVlTmY5dVpERWxKNkQ2dmJWSHJoLzZKMndFaFgwN1RVeEsrQzlLNDdvcThY?=
 =?utf-8?B?VHMyVUdKaEwrYVlXVk1jWmVQMTJqdzZ2TzVzS2dJazdySk1IQWV2YmJYSDZs?=
 =?utf-8?B?WXNleCs5UmNocUlpbE13SlVnWTVVaW82NFVZeHJIL0QwWERUTXdVcUZFbEU3?=
 =?utf-8?B?VVQ5RHY2SGtMZ2JkOE5lOFN1djhMeHpxUEh3c3VJUW94Mm5sbE5pdzkzdHFE?=
 =?utf-8?Q?GYJmn7nIex4S5dDCY8IybFZqrmQ8RA=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:22.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e04555-f145-4b27-93b6-08dd2b5f6e00
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7141

The driver now requests that the bit rate configuration should use a
single (common) BRP for both CAN FD bit rates by setting statically the
CAN_CTRLMODE_FD_COMMON_BRP.

This is needed because the esdACC CAN controller has only a single BRP
for both bit rates.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esd_402_pci-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 1152182aa64a..29ffa152097a 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -447,6 +447,10 @@ static int pci402_init_cores(struct pci_dev *pdev)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 				CAN_CTRLMODE_TDC_AUTO |
 				CAN_CTRLMODE_TDC_MANUAL;
+			/* Mark that we always run with a common BRP. This mode is NOT
+			 * changeable by the user.
+			 */
+			priv->can.ctrlmode = CAN_CTRLMODE_FD_COMMON_BRP;
 
 			if (card->ov.version >= PCI402_FPGA_VER_0_72) {
 				priv->can.bittiming_const = &pci402fd_nom_bittiming_const;
-- 
2.34.1


