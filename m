Return-Path: <linux-can+bounces-1410-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B496CA6C
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26CB2877E6
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA917ADF7;
	Wed,  4 Sep 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Ox/jzPml"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020142.outbound.protection.outlook.com [52.101.69.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004A17838B;
	Wed,  4 Sep 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488869; cv=fail; b=SkOVwYjYyiQ1iuR+CxBIzRNG+U3wS1Q7wcgXd8GVyT90KHK6v2kQpYLl0df4ZFn2YXpMcDqZMIj9VagUqQQ8IFXNRLvaTKTTzzkEFMaISyltwwVGeUMhMtVfve0OgFb2YTBDsesSFQwicQwSxJK7qIYuUbKHPNBUbI7aUxlCyPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488869; c=relaxed/simple;
	bh=+EItJRmoNehfrDzQGbTbRCKy4RBNa+J555PXOHmOkSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lUW+TqrAZ7TPk02Q2kX7IZugzqs4r6WeQgppgBdfY+x/vZaSj1aaP8zUjDzX1oyOAWPAvY7nFcTKrTe6c7Hbq8dzHdFsK5C+eNEyLrWvZieSyFmvF91OcPIeyNX5/RtPWYshGDnd1e+E6ykUJrWYu39n62DSImu8FFYAUA7bcOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Ox/jzPml; arc=fail smtp.client-ip=52.101.69.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbIW6QAfr2p1oiK2pBVMQ3d3viHbGi+e1154Mf8qXnjn0UmUT4/ThfwpFnTlFqz0TvwSG6wJmEEi4AKT1M+J9OvWD/A7JoJtMm0dU/Idoaj3re8PY/EaaX81nAX1vT8ZCjQ1LDgzmmgQUVWXtlsKWSJvzDdKPn2Z3ODVVZHZzb3lIlP5jHDiaXyKXXSFdaFoisCbwxZYoVikxrqbdVpR8s/IW4AdjndJi4Vl0PcrRydbbCr04i75l1NXcO2wIucJgkOJrmAZDwVfEkYbbE5SaCbyIZvQxroe4UZJRZWFkJXxr2AGH8WgBUd5cX9Vnep+9Aj6u8B5p2V2p4wiLHaj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocjF7m0TTKnSOL9U0uJMcIBDZzueiFg39loyc/Ri9QU=;
 b=x1TUdcRbMiS9cfmYqFtupeCJ6XoXzKIk0DZYIkqYfX5BGf4PNlIe7VMwWky5utmpdDA/xK5+kcvU+eVWABLSrUCoI5I/jpYh5UY1TdMSdPgzDAhUg/NzktKm/CfnSdV/oNIohVLFwtTNFrZQi4DeFN+LZWWEpidK3Fhg/0GLoSkC5zE0D7CNvJsW+4Ub+j8Pwgh0Kd6S3phc3jbvVkMpKIkg0mZ3Q7U9KUnEZZdWT8FIH7C8xpBuP7lCt3xCP3luFKuMe/f3xx54vQM3MDpU6coHtPNlbiRjg4heQNn/ZZQU/jTGtz2Rle42vyAXhJdKUaGQODz48GROH97WSPcpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocjF7m0TTKnSOL9U0uJMcIBDZzueiFg39loyc/Ri9QU=;
 b=Ox/jzPmlkWsDKnwxNb8nfoJn+OmPX8zuyNeTHLdf8z1OE8957pza7V+lWmgUiSM6z96J6UmJ6t9yZmPpJErA5xbaWPXkBr9GMJ3+1QAcGwtVsb82sfj5x8T02AWBIKeP3hCMnjx66XrdL+1OYMzRCx3YMAwuUH4m+w0yJwFjGKY=
Received: from DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) by AS8PR03MB6888.eurprd03.prod.outlook.com
 (2603:10a6:20b:294::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 22:27:42 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::c2) by DB9PR01CA0014.outlook.office365.com
 (2603:10a6:10:1d8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:27:41
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id B6B1D7C1278;
	Thu,  5 Sep 2024 00:27:40 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 9CC2E2E17AE; Thu,  5 Sep 2024 00:27:40 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 0/1] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
Date: Thu,  5 Sep 2024 00:27:39 +0200
Message-Id: <20240904222740.2985864-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AS8PR03MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: c526b502-2c2e-4ff5-6312-08dccd30ca0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnY3SjI2WWR0QXRnTGkwZEsyUFhkeS9KWXNoMzQwTnR2b245cnk4dnJvbmZE?=
 =?utf-8?B?azZ3RVErZFVwTEEwRHViaXFva3JFa0JYclVUU1FGbjM0OC8zU1k3RUdYZXEz?=
 =?utf-8?B?YkxZcWVSWXM2Qkh3TFVKYURQMmxZbjhWbCtOV1ZsNllNVm0xS3ljUHlxTHJE?=
 =?utf-8?B?c1FPRzBvUFplamdNZG8xVHQ4dVhSRVV4TWhJZEtWaUMrZ3pjTE1sR1NnOEhQ?=
 =?utf-8?B?Q1Nwc0ZTYjFFL0VLSVlvVmhlTVlENGNWcmRxbzEzTE9PK1FiSXErL1l5TWds?=
 =?utf-8?B?QjhWWU1saFlYZ3QwVEtQMW9scnBURDhncXhjQXRENkVNdEdmOVpiellNQzdj?=
 =?utf-8?B?amg5Q2trTXdoT3lGSTlsSG11VGU1RXRESThpdTEyQ3NINjhGSFkvQkh3QXBo?=
 =?utf-8?B?VDdaV1VJb1VKNkhZVGF6cExnS3lFYXBtSFlwODk4dXRWcllvaE93TXQ0Y1RN?=
 =?utf-8?B?SlMvOFVtV2krMkMxdVhtVkcwb2tDUGhpdHgwQmVvOXlVeE5jSm04VURzK3pl?=
 =?utf-8?B?c3VYWmMySUdlUEZyVllIRmtPRHZVSWUzaUJSMGV3K3h5Vld1WW5PWFlSRUZJ?=
 =?utf-8?B?R3NlU1ZELzlpSlIvMnRCNnlDMnRKdDRIS25xOHlMYXFSMkdyREhYWjJzK2pF?=
 =?utf-8?B?eC9abWljWWxNcUxCVkJWVjExZHB5R0hwTEVobkZDQk5Sa1NCRjg3bHBRb3d5?=
 =?utf-8?B?cWhJOUpJVk1CdmZWZExPU2dKMEJlV21sZWtpNXc0Z3JMK0NKRkVHdDlHc0xU?=
 =?utf-8?B?cDdob1NpV1MvZm8wR2Jhb2hEMURpanc1WDhOc0FtSFIzN1QzUXg4TTlWTmtU?=
 =?utf-8?B?Z2hFcjhUZGZkU011M2Q5VFFhSnhRNjR4N1VOQ2tsSU1NUEp5S2VJRXJ6ZWFi?=
 =?utf-8?B?QnJGdnRnNXBuZ0lzL2htRndubXlISlNobEVrRHdFbkdQeVJDejBlNFI1TmNH?=
 =?utf-8?B?SEc5bDhIQUJ5Y1RwUS91Umc2V28vOFRydFJCQ29MWEtsb3pFRU4wcWVOeC82?=
 =?utf-8?B?WUMwdW9oNzkyck1GQStDZ0tVYXlwZDl5cEtFN3VhYmwzUWZMaStZTlBKaVRJ?=
 =?utf-8?B?WVdjMGs1NFN1MmJvUjlLcTBYOWJ0TWZwaktOcHYzR3pQQmx3dGpUTXFoejgr?=
 =?utf-8?B?VytPUXF5MEYzcEgrR1oyS3Qwb1I2TVBpVFRISlRvQWtJRUdEOWZzQVZ6N3F6?=
 =?utf-8?B?dGVmSnJORVFKVi9yaUU0Yy92OU9JdmppYi90d3JWMWF4enpXMTRXOGgyLzd4?=
 =?utf-8?B?Z051NmY0TmlQc3pad3A3bHkvbXU3T1BkUU8zR1liVTV6cjRRbGEybzJ3TUYy?=
 =?utf-8?B?Q0d1WDU1SzZDdGtMME5oQUh5U1hKR1IvV1ZQNFhya3IrTStsSmY2ZU9yaGZ3?=
 =?utf-8?B?anRRRzBDRTVYeUs2SmUzNURMcm1tbWREVFQxcEZYRW4xZGFjMW85Lys2U2Er?=
 =?utf-8?B?b3BCSTFKeFJnNHVnMHlnVjF4RjExdllyQ3VYeVJWUDJaMW12MmFKY205UkM0?=
 =?utf-8?B?WEUxMHlmUVZ1WGhOK0V6aU10OVJWdUx3MDA0bDJ6MCt4MVBwTGxpd3A1cDIw?=
 =?utf-8?B?Z1o3Q0FjdXBlV29CUzIxcnRicGhYbkhVbjRXTHFZSlNMVGNId3BVVGcxL2NJ?=
 =?utf-8?B?bDNydmZDQlJtQXBWOWFVc3k0VXRWL1VicmN1VGo3cjFzQmg5MDFxTlUwNnB5?=
 =?utf-8?B?REh0UzdXOUNzSy9HRy9TY0dDZHJ3Zmt0UVcrQjA3R2M3MHFjY3dtZXpkU0Nj?=
 =?utf-8?B?N2R5WW9UTGNUUkxkRlBYTW00V0NSeXAvMnZGdmc1eHhheHY3S2hjQVpCKzBN?=
 =?utf-8?B?bHhyNUdMUzlSU3F4bVFGS0NVYjhkTzkxSG9aaVk2eE02UjA2djN1TEZQWm5H?=
 =?utf-8?B?aVprWit3VTVHMy9YdTdwaUlXK2NoSlpURlA4Z3Y5UVNPeGVYZHlQZndMbXZI?=
 =?utf-8?Q?DNS5++3OGWAzIh57cKFbL/+UhM28soZ2?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:27:41.0829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c526b502-2c2e-4ff5-6312-08dccd30ca0d
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6888

The attached patch removes the announcement of CAN_CTRLMODE_3_SAMPLES
for the CAN-USB/3-FD device.

I see this patch as a candidate for inclusion in the stable series
of the 6.6.x and 6.10.x kernels.

Stefan Mätje (1):
  can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

 drivers/net/can/usb/esd_usb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)


base-commit: d7caa9016063ab55065468e49ae0517e0d08358a
-- 
2.34.1


