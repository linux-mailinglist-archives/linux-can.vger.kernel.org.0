Return-Path: <linux-can+bounces-2103-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787939D212C
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFFFB21B7E
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276719CD17;
	Tue, 19 Nov 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y4TP+etL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B6157469;
	Tue, 19 Nov 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003320; cv=fail; b=Q32nTwXfWqLyIahEV+SA43NW8puMFbFiknMgnNT+P4EZTaXDScz17GG654/UdBgcQfkhRnIs3cwpf66ZSLBUVEB+DscCQymSrL6oDZYUvuXGQcJ9WYf0AjgvqM2PfRE8AGrR0sUdX4xRZr2d5ZtDi21TrYT+N8eMrzA6a9IQx3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003320; c=relaxed/simple;
	bh=s5GyuIVsTRuB+40aK1xPdi/4m/eU1k0HoIdFk2wTwjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4GyN1A3DRnQejIvoZSkYaKnAP8aYESE4zh4N+awQMEmgEoF7tINp4HwWQzmwMX8ETy23HvdEDPDKxMzIM2eiEho6mNz0MzPpUBPhPMVXIUnNGsIWTyI+/uW0nxd8VITUtOp1P4H2t47m+2xrg3/GctNLdjVEsa6EZkJR4gY/08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y4TP+etL; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaRb9/Z+AFsNsMjS6tI1pXc5+twwCyv3lKdjwXMLLABdwJC+KDMpZZQVpeMTe99XzVkf1tmWxuavhkfgTDVBlIhssmeNG043kHuLJvWRIZZ9HbVb2vrUxtBgVqaTgedhTI8mx5wyouuhUAO5IJaBmjQ8K0SmH88FU+uM3arnYD2NSJ12rS9dC7u0zG66Nt81TaOkJoxQz+6aNCF7i3QeF0vZTV7o+6EeN0FHskAssq5NC1hsDbGunmUzd27BHaoH7zS83B5cuTkT4XmcvtYi/piKWQ6X8m4PTZkzEYOETbHpO4xgAMNhwykgtJAaV4EVOJPKRyK0qytJSoIGOwlbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQz1hpJ7w6n4hw+ZQnp6Vi37ibD95Iux605dlxQo19I=;
 b=l47zWkPUCpofHERG/D9EBJPDVtnZXSLudak+W44+uJ/tgecy/C5Vr7hGH/eYijE/uKUqfLhNJKsPic7UnjMEnsicxo1frXEetlZ+LclTCrR/5GERiPYKu/XNi6ar69Mo/Q4SiifPeDtA90zUhaqYXbLDRPq4q3+O4Jg8Y0jUJCRQyzVRZMqS3aJBXylgOOySkO6MNWIlQmsB3QoyjUfyTLD18xU/+ptvduSFH+sCOLsScY6qSCRgoDLJLj0brseptOdaJhHTLneK0fpI6pReR6ZVQH5GbD+mPu2TU76P3VnlxHLUPiwjYk+nfD8WKEmiTp8VtY7C7hQUDnAys1IhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQz1hpJ7w6n4hw+ZQnp6Vi37ibD95Iux605dlxQo19I=;
 b=Y4TP+etLdJcynZXnwJ7DYNEOcVGQGH4VhbV1JbBUwPHb7i3CBlrp6Qik2UhWSlCZGhhZWhNh/8MxtysfZvtS/1UomS2RjcKO37V/E0wSjQgzvyXKS2BYBXiwWppOEoHW9Z3XQV/OeYwOBWnbE8lRm39dJ+9zdlNt7BKchafptCF+e8WI422L6RPVHNVhBRR6Gd82Heq5YxJA6ffv1nylHE69ygi1Evd5EpCxm7piPHUmrpj9DrihYkYdswqftMa8jGjeJ9ZQWD8OD97N+mmlgRyHMp+2aXjArwG235V13J9s5j6LSPAdAalmdNSuVp1FRF2c1BPcsw8sB+9WVmrzVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:01:52 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:01:52 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Tue, 19 Nov 2024 10:01:43 +0200
Message-ID: <20241119080144.4173712-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
References: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0037.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::28) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c77b13-d01e-4af9-abaa-08dd08706d61
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkZyUEdlRlB1SVF1OXBmNGw5aDJpZDJYWEljRTdiZHBFVXRNM0hPRzFZYmIz?=
 =?utf-8?B?M2RYSW5JdkZVUHEzemRkaEd5bU1QWFZqSzk2MHV1akNpR3pRZzJDSVAxT2lV?=
 =?utf-8?B?TFFyRjh1a0JEM3A1YlBLV01nalkvL0lqVnVSYjhsMkFFWllaNnJmT1BpRVoy?=
 =?utf-8?B?L2RtUVNRSTNkelczUzV4UW9FdFBvWjBiQTRjK1FxUEdrak1pbE8zcHY4SENa?=
 =?utf-8?B?d0V6ekFxbTd2Ymo5NHFzTExhYXVuK1d2R2c0UWYzRGtKQ2RCWjFJRXBBclFU?=
 =?utf-8?B?WldjbnhDMDBQRDhidHIwOTkyMzNZallBaUI1VEhQVjJhemhXKzV0QzNUaU9S?=
 =?utf-8?B?blk3ZkRZRkpnVHA1ZnhQSmJOSDFSUXJkYjJRWmtRR0NBYjZkOVdENlpFYlFB?=
 =?utf-8?B?Rk9xa1VyQVM5bThYc0tEbWdkY1d3WWJPaVpERFhjWVJDSFZicHRmSDJESVJ3?=
 =?utf-8?B?N0NrS1JKdDY2VTU0Q0s5WXppVnFQRzgvWjE4UktEZHkvaHNBdEFGQkJianlw?=
 =?utf-8?B?eitMMi9ybExJVTNNR0FHL2RWeDlFV01STElvV3U4ekdxbzk4QWZkZktWUHBQ?=
 =?utf-8?B?Ny9LdFpaMU9hMW1qSk16NkpNaWh2YW1yOWo3VWRwY1Y2b1UrbW1TZDJWZGtB?=
 =?utf-8?B?eUNLbDhJT3ptYTFobzR5Sm8zYXA1ZVJpOHpod29KNm5tK3pSZTFyVHVVcjNI?=
 =?utf-8?B?OEdTSS9lNXduR0NvWTNIOFNIcm5JTnVIeG10NkNvd0UxRHNwc01hLy9KMDUv?=
 =?utf-8?B?Q0xWWmJ0Vkk3Zm5ZTDVZQWhhU2ZOYVF6aUs4bHhnUkd4YmRDOG5GbFNrcFhv?=
 =?utf-8?B?VTBDbDBmVVl4a3BRSXhRWGpVdmVOUkN1VHBNODlnM1hXMi91N1o4L0ROZ2dE?=
 =?utf-8?B?R2xuc29EQ2R0dzZQbEdhaWdEb3RpdlErRW5IU3Y4NmhtWEJIekZhWE5ad09M?=
 =?utf-8?B?M2krMWJhWkFNanF1dXkyZjVZR0hOeDQxUzU1VkJyMlRtUmptS0RCU25SZ21E?=
 =?utf-8?B?a1duVGpoM2xQNWlleEkxMmRFdm15cWk2aXczSlFoRklPVVJkemlOWmxvNGN1?=
 =?utf-8?B?Mm5jdm9lamFWMGQwbkNIT2tIbnhjNGV2cmI0c2ZWYlk1RzRDbEh2bFExdXhF?=
 =?utf-8?B?dEI2NnVBSjN4NVl0dDIrcW5NbXBKdGVmQnVkRTVEbHZ4QkFUMXpRZERlQzFY?=
 =?utf-8?B?TnJTdDJxZ0pMUmI4RjE2alNpYkJOYlBiL2FPSUV3d00vNGJFbHQ0YjdlcTVM?=
 =?utf-8?B?SVkybURJcDBlWjNMemE5QUZ4UGdEN0VobGVnYWhRR1dZWGJzK0pDRXIza2xF?=
 =?utf-8?B?OGlYSFFRMjU4dXNOcTFwQ3pXd0c5S0w0LzdWOEpTbkZHS1J5L081V2U3c2dB?=
 =?utf-8?B?Y2JRMnQySnhyR0hiWWx3aHg3eTg1LzJaS0xTc3BXbVI2NzI0dlVNRWNWdGVO?=
 =?utf-8?B?UElNc2orVHhBdE9wMDlNak5EMVRzVjBWYy9Vc2lDMzIycGlmYVg0cXhKQzZq?=
 =?utf-8?B?QmVDcjVITTlvcmlCUkM5VjVUdjIycm9TMW9MSU55UUtXVkRWdjcrNGpScFJy?=
 =?utf-8?B?UFk1ZGtEejI3M1dYNmZOeXFiZldJMVRmZ3pGWHBDblhyUkREMzluclhrNzdw?=
 =?utf-8?B?THFuakxKbUxlU3JHS0w1eFZIdkhicENZSkM2ZWlXU0pHSFczYUZIZFRwcDNK?=
 =?utf-8?B?OXZIUkxBSHRvd1EzV3JlTlVmSlBDL2dpUlRlbFNkaitxTmZUZjZOMDZwbENV?=
 =?utf-8?B?dTBkZVJEbmU2Rlg4SEMrZEQ2UjJqMFNoUEhaOWcyNUQzL3pVOC93clhYTWt0?=
 =?utf-8?Q?J/RtMyB1UmF3h9yHWNCYu6PJZfHqucMmvzqio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJwR1VIbHoxeUEwUDZXOGZwVzNUMXJFT29heklzeEEzTE5tVDRVMTNwM0JY?=
 =?utf-8?B?QjU0SGNiV1hYVzgxdHE3dlZESDVSdisvUlhuNFZYY09rZDlqb2pFOUlKd1Nl?=
 =?utf-8?B?RWR2VEVtc0hnZkJzUGlWNi9rS2FteUdwYVllUzY5R2ZVS3ZNVGs1MG5zTGw1?=
 =?utf-8?B?YnM5OTc1TFJXd2tlR09YQVdxdXNWMDhaUUpaVXNvY0NVNVZXdDFhQ1UybnQy?=
 =?utf-8?B?aTBPQjdlaWQzVit2eE1sbFRqZ1Zvc256NG9kNFFEMUpYZ0JrNXlyRDcvbEFt?=
 =?utf-8?B?Z1JINTdRejVxblYrekM0WjJicDBNTnY1N0FGU3g4SFZJUUF6Q2Mxb05FK0h0?=
 =?utf-8?B?VmNURjltcWVhOXdVMGVFRFBqNGI2TmUzK0dmOXZWWFA3SFhzUUFKSTgvZjhZ?=
 =?utf-8?B?QVROUVJJQzJ1bi9SUVhGZWIxbW9tZ0NjaWxOM0FxLzc1dmNRSHg3QkExMEZt?=
 =?utf-8?B?ZldYUDBldEpQaThLSmFyNjMzaW9kN0pqUlJLazRyVkdvMWtQTCtaODZOQnA0?=
 =?utf-8?B?TTd4ZUpicHVSV0VzS3pQT21KMHRoMEJ6cnMzY0o4YWZVRGxXandVUk5ibDBW?=
 =?utf-8?B?MEZQZm5zMVZBUWdOdEttTTVSM3UvRmgyWDRyQzJyaHkyTGx5NUoyTTVMb2Uz?=
 =?utf-8?B?V0crTC91VDZKaWF5dUYxTlNKQndQNlNUS1l4Wko1Y2lSMzRaK3BZRDd1N2NK?=
 =?utf-8?B?RHgxd2x3RXg4MURZK3AweVRGYjZhV0pYSzIvRSs1M296R2xUQWZRY2JCZElX?=
 =?utf-8?B?TjBDeDNzYmlQcXRsbFh6QXNnQ0VPSjJUZENVdVh3ZFJTWEx3MERQNkowWVdQ?=
 =?utf-8?B?QWIwQWZ2Sk13NnhDOFNWZDRaeGJjYnpPOUttZm5RUTVVcCthMmRUcjhZN2pr?=
 =?utf-8?B?cFBYekdSK1lONXJPN1MwNUpTRHh2Z2dDWkp0NUcvamNwVlJjUlVuNWkrYmRm?=
 =?utf-8?B?SUVWUTNzOUhEL252OHZ2ajNaVGV6VjZIOGNiMVlrSzJQTzAvd25sMWpaTVR3?=
 =?utf-8?B?Tmh4d0Z3eE44OFNySWF6ZG9xdk5BYnJPTFNHN3gwUlZSOWdvODZkcERPVjdQ?=
 =?utf-8?B?MG9oTVJOdWdqN2Jid0JoTWsxZXNDQXNGeG5QZ1NONzV1eGczMlh0RzlCeTVC?=
 =?utf-8?B?VHJuNm1IY29VeEVxTXlLWlUybGgwaW9uc3VvNEV1QXhPMC9mendKaE1pY0Qx?=
 =?utf-8?B?MytlVTQwYWtOcFZSdjBJNGRjaTZ4enZiNzk4WHB2djUwVFE3VFhQaXc0K2hF?=
 =?utf-8?B?a0JMQm55bkpLMUoxSkNRRkNNUHhIWHoyRk11MmtMNVBPbSsvdVRNUEVnTkFq?=
 =?utf-8?B?RUZkY00vQUxjYVdRNlMxMWdkWjJKN0ZRcVdxYi9qWFl5RW80azVMY0pxQjZj?=
 =?utf-8?B?cTNIb1BhRjV0NE9YMDg1WTMrVTI4Y1MzYnNYT3J2cTB2WW4wQWlDK2VXaHNm?=
 =?utf-8?B?b2pIU3ZNMXdVRmNBVklpM2w5Qnhka1o2d0ZvcUJ5bDlPY0pnYXRZalhqTGVR?=
 =?utf-8?B?R2haZzJrYWtQV2o3VFFGdzdVcFhaK0h2RUJxMXFpT2svSU1ZeTZoTFNvSysz?=
 =?utf-8?B?Z2xFQnJQdmwxM1RkT0VkTXlUTjZLQjFsSEZLbGFRaThuc05Zb0FnUWtxbkti?=
 =?utf-8?B?LzV2cjZSTlc5QzVXdkN5MG8veW81OG1DNjltTW11WnNXeHVsU3l0RmgxdTd2?=
 =?utf-8?B?TlJSNGJDZzVwcXhUNi95YVVvY0tJRzN1cVJFNmhRa201T2FoSVJOQVBTZG5T?=
 =?utf-8?B?aGN2L3p6S2RFazRqMjYvMHhxUmswOHBVWnpMY1pGazZxQUVNamU2NUVOc2ZE?=
 =?utf-8?B?Z3RhVTY4MDRUSXRZMW5wV1k2ZmxRYjJ5STA1bXVpZ21EWC9CbWRWVGgyZjd2?=
 =?utf-8?B?NHhLdldoN2NIWk1VUTRjU0lqYnRjbXhOa0U5bXpoZ0tiU25LL3FRQTlqSzBE?=
 =?utf-8?B?N1pXb2pjVmJFK25kbW9zRmlpNXJPUytROTdkZHd1clRvR1JtNmFUM1IxcXlG?=
 =?utf-8?B?YzY0aUI4ZW5WZWZzUFRhbVBiL3IvVGVNMURqcERQSjhFUDFIcElTQTFJNith?=
 =?utf-8?B?d2FYWlVpN3pWQjgrMlFVdG0rVlpIaXBFQkdRVE9BOVNKYW5JY205T3dtUCtt?=
 =?utf-8?B?NFFLdVUyRnp4UXZoUjNRbzF6cTNMYytSRUNlWFZXT0I5Y0FHeWM5a296WWl1?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c77b13-d01e-4af9-abaa-08dd08706d61
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:01:52.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miK7onlwZXUlq7UF1FshEN/NkE76EO3uqp4w+qyycFEQ936/dZwvmAZvF4QkaHXpwVnW57Sl8FKRav7isJtk9W1JpowhltqVyMqCqyaQbpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different. This initial S32G2/S32G3 SoC FlexCAN support
paves the road to address such differences.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..f0dee04800d3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,15 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2041,6 +2050,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2


