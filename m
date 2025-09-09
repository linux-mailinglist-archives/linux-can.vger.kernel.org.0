Return-Path: <linux-can+bounces-4536-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CEB4A15A
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957C6446784
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2C30146E;
	Tue,  9 Sep 2025 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LByxkH1w"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB80301462;
	Tue,  9 Sep 2025 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396467; cv=fail; b=ZOD8ZGVeAP0hrVPYN9kTVq4FR4zVanzdgcpZYCWienRkbZkl5mrgtMlAb790uDM9Uk1ILYnbQfHh0VU+7KUo7r8bihkEvCVQCrabfm/V5G7RoKkEwFLZkBY9niK1E4PqPBDu9mBN0Zx3Y71jEf2ZdH2PSGe0S7WjeeYXhEn5Gqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396467; c=relaxed/simple;
	bh=3m6Qd2ReNWy1Qz9hVQLPsivAvDAhZXOsZg8hE68cfio=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rAWtkRqYXY12oJq3t+Z+ilcVu/i+wsus/3T7ty9j8wVbOnR7rIVZf+KsQt3w0y9CT892aczZiSqDukonInbNo3r6yKiVS4q/PttQRMjsincRn9EET/IwNvCL0lAocf8yPPhLFKCWgFz/fEu4eC7z+Kbhpljf9sKoaeEDeE6OVms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LByxkH1w; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN0TkFblx1LLc+V3pUrGRny8UbwQh5JGfRXiWRKizV0zkeXAgG6jq66xnPJFChXdknNACmacvABpUI4Vb61XHhvL3ARftyYGEF0dfp/3Pqd6Ojh3ZxwaeU8qTDSdXEKZdvRSuNYcybIvCPhDtq6WWS1KM1sxUQL1BuKGYgpiZUSLnGhkkubKr0DBZS8JP5j1s5HpVLcuFBCYj7SQEtSo/VN1NMU6OU4I9QVthkFA8pOENkl/fZta53eHDa1Meg8j4WEKJWWoUpennq9yvVjOYHGzGGB0T6bC1pQL0Yp6A0fYPdik079ZZw3SN7LumTezPV8TSD3Rfa0wcqNtTjT+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2430dZd0Vb6Wn5al4eWb8J/CgIyz9cHp5WQaS0GLVE=;
 b=ezlFahGJR8vUhjN+9V4LAS0eF0QSwHrnDc6WG8Ps4GgZGRGtDSJh0JvsTWBwST4JMthrIin9XEXFH45SO7rT6es8vU61uMUdfEFUugKolVmHSecNPUM8gD6YAet4Q4Gfwwiy4MmQ//gZlx2FbFcqnj3HUj449gNapxxDc6Sbqskicys8FARuoJZ5MnVfyXuol+mKfU/EiY5CHUxL2dpoWkkKDIutO7/0NJ23mpyDzMiRwcicUffiyKdQL3F2ctH0Qnvjd0O7dW3lbDW8RnZEKhCx0CitCVo+WGFhR0BCIjJZJ/wyFjHmgY4+s3iXOEQZAbpuRn0Hckm6zzB5KMG6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2430dZd0Vb6Wn5al4eWb8J/CgIyz9cHp5WQaS0GLVE=;
 b=LByxkH1w79qJ9zdZlxYAcP+OkoNvBi0gnx7SgVUQtypXzSXk8elabMEp+q0DqEkFjyaDCXuM2KSmJhqrvTqow5zOXwcn2coxBiE/GqxxX06ZB2e5Ui94zqH0xK6o5NAijA2slTnGOMVfmfGZaqiZtIacYkHrqdZz5j10J1XgijR8kwnnZvirNJE51slYKqFsf8GsS37Qw6TpHgBl1Oo1t35qbg0SFpcBPCKzJHmsPpkMRGr9FatewUxOzD+PafbLuShAP/Zg2dyODV1frkEt45Lac4mE8zjyokrXqvdIyN0x8gNTKmZzW0YYkXur5vbUFR0hba0SYwlrHhJgZRhiqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:41:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:41:02 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:15 +0800
Subject: [PATCH v6 5/9] phy: phy-can-transceiver: Propagate return value of
 gpiod_set_value_cansleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-5-1cc30715224c@nxp.com>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
In-Reply-To: <20250909-can-v6-0-1cc30715224c@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=1835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3m6Qd2ReNWy1Qz9hVQLPsivAvDAhZXOsZg8hE68cfio=;
 b=Fy9FaXiO8AdtihoOf8XVltS4lwUikZyQA/j2nKJ0HZbmblrn5LR3/oIFMcpROm8OV4AX09In4
 tHapPWeMil+A+WRrXnB5gZ+N3Z8hHT8yOqPRgCf7Q3qIJ7B5IOU5mR0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: e217a3f6-1edd-4536-3a7d-08ddef63768e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJCNm1nZS9hWE1DN0ZlQmNkdUVITkQ5WkZ4ekNJaFdWQ25NR2JNUkJsVUtm?=
 =?utf-8?B?WjdvcnllRlU1bXp3YkoxZ05tRmRuaEZJTkoyeGJ2ZEkrd3FFRlphOGJBT1dR?=
 =?utf-8?B?WCsweklQdVN4ekY5TG9kMkpyNVJFNFpKVWJ1QWh4MDcyOEdZSURObG9hcWlV?=
 =?utf-8?B?aHlsL25qcGJKN1N1MlEvSTZUL1lOWUNscnBIVmhmc0ZHNmpSRkVaMGkyeG5T?=
 =?utf-8?B?SDkxR1BsTlg3ZUtYVzczd1JVVXpjd2pmSzBzUFRmQkhISG45RGM2dkxTWXVC?=
 =?utf-8?B?MnVpN2lGN2p6cFhjbS9KUys4V0EvRFBadE5obVZjNURpOWxXMzB0TUV4SURu?=
 =?utf-8?B?cjFFemJDdmRZV0tzT2NEd0lVajRhRFBzNXJ0NWU1OVIvalQzcXl4a3pYVlFU?=
 =?utf-8?B?MHcwUm9PcTNhTU0xbERFenJlQU5CcnJ0dFFFWkp0UXVUQVhsVWxBbG5mb1p4?=
 =?utf-8?B?eVdPQlRxSUpaZVZzMnJnZmtUcDZPcCs5UEdTN2RzL0YrRVhkVWl2aU1aUGV3?=
 =?utf-8?B?QzFJcG9jRFY5R1Z5bCs4ZHRCbTZhSm1CWmpyZ090cE04RFZPN2V2b014QkNn?=
 =?utf-8?B?SllvNDZCOVFqSWZtYmxmQmgzN2k2VTQ0Tk1qNFVCUDNOcEpEVkdIVUxDZldq?=
 =?utf-8?B?czFZbnNZVlBuVVdQRHVQOWh4b2NKTFpkN2EzNy9sUjZuSEQ1UnpySHVYd0Zr?=
 =?utf-8?B?WHgyWmFFdWZFaFY5SGo5b3lEaXd4VnVRVHV0OEU5REY4aDRsL3FTNFdQaWxE?=
 =?utf-8?B?VHZoNVVPZjdrc3ZoaTNjczdvMk40c3ZnQkNNK2tYQ2Z0UUx5aGJKcTFvUTh4?=
 =?utf-8?B?cUE0WkZ1NlE4cG8zRHovZDA4VUF1UFdlZlNLYzhVZWtVNWRoeElpQ1pOM05l?=
 =?utf-8?B?ZTRRdi9LKy9RNUM0dnZaaXppNVl6SjFNbWs0OHIxL1IzSHpaSUVwVm9wK211?=
 =?utf-8?B?a1NJZGx4MU1CNUhUZ2lUVUlxR3NPYlg3S2t2S1hOaU1aREt2YnZJV2JlR0l3?=
 =?utf-8?B?WkRHTmo5V09GakVmQ1VTa3VpeURaclJuMHJENnNyTUVZZHF6ZXJHdTcwZmYr?=
 =?utf-8?B?dDZJTTRwVVl6RnZ0akc5bFQ5VXFSRTdtbjZ4bXpPNjRvakQ1Z0dwd2Faam5P?=
 =?utf-8?B?UHB4d3ZjOXpOdXBuakVwV2dlQldFeHRlK0dSYnVqMzR6RGhkVzY0UkxXT0g4?=
 =?utf-8?B?RVV0eUhsb05QKzVhWWVOazZYV3dlNzFhZUVTOU1IdFUveU5NdlVIVHFzUE9Y?=
 =?utf-8?B?bTZNeVI4MUV0a0FOc3dmbkZzdjJwUWxqSFNnT0RSQ2Y3eStSaXVVUEZVM0FT?=
 =?utf-8?B?MTh5SGZJaEFERnhIUGtpYytlTFNwd2dWTHFCc3h6N3UxZHJucFFmMDRSdTNM?=
 =?utf-8?B?NDFNQ3lrdlB3aHlZYXBUOXNBblg4VkozTHowSXQ1SkpMdGM3RzJDZHFtNlpI?=
 =?utf-8?B?NTlzOWVFcXdXSHQ0Z1oxWXVjQndidVVKaFhHckp1V2o1enZDYzlkWHYvOGdp?=
 =?utf-8?B?M0lsV3JEalNidzRuVGhYc3dSZ0M5UnAxdExMcllnOGN3U0ZrcldoYjlQVzI1?=
 =?utf-8?B?S2VaVldtdmoyQVpqbi9MdXBGcmhqbEVaSGtrNno0WjdYdGdoUk9pV29wbjVR?=
 =?utf-8?B?VEtEbkJYYnF2ck8yOWJPT1puaGtaV0U0akVrZHlrL0RycFEvYmcwSTZ1a28w?=
 =?utf-8?B?NmlobDhqM3phY1JhcFcxWlRqeGNBMmZqb04xQnVlSXFPS2pmNzdwZDZ0ZnlM?=
 =?utf-8?B?SzNlR2I3bjJUaGxqUm5WdFZ5MzJ1TWNuSU5XY3JCMjdXa0hUamdQdElDWGdF?=
 =?utf-8?B?RlpHeW41d1JiV1Nvd2p2Q09mYmxVckdZUkRNMURrLzlGNHZXY2t3Yjk3Q1Ay?=
 =?utf-8?B?ZGtHNG5uc0R0aTlyb2NVeTZtRXIwN2dzTFErZXZyQjdhbG1uR1M1czBYbGM5?=
 =?utf-8?B?ZklueGdCOXpBQ3d4U2ZjMFc5ZzQ3WERHOEVHVEo4WnNyOXdQc3czYTlqTjV2?=
 =?utf-8?Q?ssrX/J7/6/e5wRqW/HDlyYkJi50Qvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0hJeXlVQWxMNENyWnJHSFFpZHZ4UmpzU2ExdzU0Z2xsMTF4YVFCZXBMemNX?=
 =?utf-8?B?UHlVdXdQNEdRMDRGZ3ZDRHNZTjF4Q09YMDJuSWtQK2hBa2RTTXhvOW9Va1Yx?=
 =?utf-8?B?THJIdFZyRXVnTVpoVmVJbmc2eWRBTXpsVlZRRENWTS94eFdXNHhndUJ6VWJZ?=
 =?utf-8?B?MjQ3MUo4V3MzL1FBZjBaYk83NTlEK2MxWVJKcVdvVVdsbzlZKzZVZE04NXRE?=
 =?utf-8?B?QUZvQXkxbnJGYW9EUHB6S2x6WTUvOG1tTlZsa0ttOWpJRUx3dFIxZ1JTQ29F?=
 =?utf-8?B?SkdENUpkdm9NK2NqY1VjaGhLdmVtQ0hIRjdvVGxZMm5aOWd1dHdCa28wNktn?=
 =?utf-8?B?OGdJTzdEbFlxU1UwV2ZzVHVhakVYMTlrZjd1UlpCcDRFRGVXSlp1eGl0aEt4?=
 =?utf-8?B?MUNFVCsyemxzNURIMytuYzhQbDRuQlBDajVSRjdCTGROb1JXM0djeHpCeE1Z?=
 =?utf-8?B?Ym9PQVFsU3JQWHBQWEppTys0NnZIZHZqVDVNZXMrUzJpL3U3VUpxY3NxRGR4?=
 =?utf-8?B?bEtYZk5BNUtVNlE2RW0wUUdhMHBnOEpFWXpDR1hvdUx5eHFDWTByZldlQjFV?=
 =?utf-8?B?TkhyRlJ0M1IrQktlNE5icmdvNjlRM25Eb0xUQ0FzN1ZaV1BGYmxnZ3lZeVha?=
 =?utf-8?B?V05hUmxncVVXQ1kwaVUvK1owR0w4cTQwK0pyWGlwb0J0SHJ2eG5abTYwcURR?=
 =?utf-8?B?KzJvR0h5TkorNGovekFSdE1JMVh2NmMwM2NlV0hoRkl3UkViSUJuTHU4cm02?=
 =?utf-8?B?VUxseVF5T1VwM1pjclh3SjJYcTVDdE8vVWZOeHZqSXBVTTZGR3g5YlBXSlMz?=
 =?utf-8?B?WlpDa1dQQXM0Tm0yMC9mZVBlVkUzNHMrWUorQVJUclN0Vi9FbGE3aDM2QVNR?=
 =?utf-8?B?d0RmRjBtMEhaMlVkcWVNc1RuQzE5SmtkekxKakhYKzRNeUlXeVNCeXdjRHFx?=
 =?utf-8?B?dFdxVVhnNnNzS2o2WThWcTlsajNZWXpxOWxyRm5iWGs5TzVsQk4wQXZoR0J6?=
 =?utf-8?B?V216YS82V2p2NDFTYjdZeWc5c2ZrQ0phQXBBSENhTmVIbHk5dytoQkZYZ1h5?=
 =?utf-8?B?OW1rM3JpbXRER0hCY1FtNldPdnN6Wm93bXJSV1JVRjNjSmhaTVNXNVN1K0ls?=
 =?utf-8?B?cURDQzlWckhpbWdIOHJNTDdqR3BzRWh3NFliQTByTlpuQ2hSV2VyWk5zRjZ2?=
 =?utf-8?B?VFlKL3Q1ekhnWjlBMzBJWk93eGNsYVgrMG1DdXBGaVAzdkR2RlVZYWVSY0tQ?=
 =?utf-8?B?QTExLzhEZ1F6aDE5WFZDdVdRZjk4ZUt5NmhCSGtoYXF5SkFZOVQ0TEorYzVx?=
 =?utf-8?B?Q2tKSzYvbkRCK3gwNitjUkluR1hJcWFmeG5PY2EzNVM4MlhybHVjTG1yTWxl?=
 =?utf-8?B?cUdVc0xmVmVKUjdmVVluYkdwZGRwSnFsQWlINGNXVW43RWNjK3dodXBUamtR?=
 =?utf-8?B?MG5TNW5RN0ltR2IyalJGTWVMUElKZlVHQ092QlZFOEozZFM0QUVNQ29ad2dB?=
 =?utf-8?B?TGRBUmF2Smw1TE41UEdydDFrVWFDbTFVK2lmY1RzMkR5d2dLNUV5eFc3TWxz?=
 =?utf-8?B?OFJoSFdqdm16UXNTRndyVE1ETWZKNDBGRTZ3bTBScVVWdStOOUN2ZTlOOGds?=
 =?utf-8?B?UkJFYWY1UWtpRHd0OXNEQmcrT1loa1NZc0FoazVMVXpIQ2J5R3F0WGZUbGFY?=
 =?utf-8?B?OWFJRHVXTkRMU0lySlpzNUF6SXF4dTJLSi8xTklkWjc5cGRWTjBwS0sxenJG?=
 =?utf-8?B?U1dETnZqNlRjMlIvekNiZUQxU0REUTVCT3MwUWQzQWk0Q3paeTd1Z1dmRzlE?=
 =?utf-8?B?cDZmRCtFWG9xbmRCS1FPeGVmZ2M2anJ5RGNtRXFRV2orSkEySUhjR01EYjA0?=
 =?utf-8?B?M1JDeHJJamtNVGF3RTg5RmFUMkhtd2syYmdXVUxqRUNhNFVZZE5FdWV0cG12?=
 =?utf-8?B?d1piTW1YSnR0NlJ5dzZMWG81REFLY3FJM2hqSXcxQU5XUzNENUYwLzBHdnE4?=
 =?utf-8?B?OHNqeEg2SUI2YzU3Vm84Q0xPbSs3Zk1WRzlWS2Vud2k1a2N3VFJIYlhxSHpn?=
 =?utf-8?B?MmpQUVVyVXpXb1F0L01DcEtldW1XYW5NTlBHU2NUb0RwOFlpRXphMmNYUFJ1?=
 =?utf-8?Q?FHAxWDkFtHDJAe+cZes9R066K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e217a3f6-1edd-4536-3a7d-08ddef63768e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:41:02.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQF7j/T3AwRnYCgBiy5KeLEoEkP7YRq0uMNsBYZxwC3n4+nwLFXR7ytu8FGULTWSZ0nh3iYBT8u/vnmslTN1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

gpiod_set_value_cansleep might return failure, propagate the return value
of gpiod_set_value_cansleep to parent.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index b7d75a78d9242e2003660a87d2d4c9f784aea523..ccb29e1dfe0d07005b4bcd8fefa2787292d921a0 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -46,23 +46,32 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
-	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
-	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
-	return 0;
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 }
 
 /* Power off function */
 static int can_transceiver_phy_power_off(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	if (ret)
+		return ret;
 
-	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
-	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (can_transceiver_phy->priv->mux_state)
-		mux_state_deselect(can_transceiver_phy->priv->mux_state);
+		ret = mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
-	return 0;
+	return ret;
 }
 
 static const struct phy_ops can_transceiver_phy_ops = {

-- 
2.37.1


