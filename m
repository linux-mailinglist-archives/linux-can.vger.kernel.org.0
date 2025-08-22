Return-Path: <linux-can+bounces-4292-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35FB30D46
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC7FA2748E
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88928D8FD;
	Fri, 22 Aug 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQVjrylv"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236028D8D0;
	Fri, 22 Aug 2025 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835566; cv=fail; b=pTOL0sCLPdNAfhXIsyx+xJIIdK/kuFL8RF9cRbpAXoHkF2o21QMZiiMZK7d1KesYR2hGwtHaDxDdCXvciRXqyaOVSuX8IfL6Qwj9AeuAf1fXBAfZH5LTqivgMXw97pweBZi6cxjBPvWHxG5tz1mljPLoNrVqQuzJ2pXcV0W60h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835566; c=relaxed/simple;
	bh=aC1FGcVpSkpo43sZ2H7cHHNebZZp+76aQpe1j28Lyh8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FgH43ChdSk70MuQ/PgtNbVlaUYiQezVfKZ1QPRglmLc7pyJ3IAtNll6YuFtSMyK9o+TYU5WmO6Dh/V2daIkSB0Jkw9JZ+PVATP81GMxXP0esMBzE5Cw0TgKloiOTZ/jK/HRT6ETo76uk9IVBg/56tvqQAyTTLblmEi6WsyKQdfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQVjrylv; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMTllQnRFbfsOuGIvTUO1XOO3noLfufpc7ieCe1Id75LXEbGGz4bM2cVFDe/DuwMzg71huXDSllD2wHMz1jGLVi9Z/GCQePb4/hID9tVuGBmdox6GvDSzx/hMDgVgerovlotXbsOQpGI70gYsbZFYUrgc7Kp5WjYuPXRQEqI8EelIL2jcI7C4Nw7/i19OFClHq1kuKOrvqzR6HLrojoaIPbovfTHe5Mxd0mbCS3Hn6e+LxhIgm4lk9YY3ODSQlSzSkBFgJ5ssYgxoatItkXhVh4me5ey6hO2kirGVN4Lb0l3g+kF1IHJJguZXDmTR+OXzOiycHzBjdTyqLgwrmgx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXnPj+o0IgutYMdlTSTqc3oZjBm9GNd4Q9xRB4ddAOk=;
 b=w+pGwCYS/wgjUOOzgUNJzbm/RPYdjXZHALZ6eZVyXktqKiOG43745k+3YShQGNc3Hk1n5buvB2MTO7MlJ+muMkC/tFQT/lBeDt9y9Ra8qIq8fhymHTPU/zolV69TmijoORrW3r/27+enHnqh/YSCzxniAlLfhTR03iaV17ORB273S8FlwORcJ/qHHPsabrJII+z3zNKDUYINgRJ6LVJ4IgLpacZSEhD1vgkaXgAtYtckwsjTOLqpa3RZGx3sBkQ4G47VHjRNSHixeIHMZkFCjknN9IFR/AO9CEooQ5+uUvTzQjN+ugwk0fCX/nTWgDTqZ9iJ6oxXF8JeEMg4xDagjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXnPj+o0IgutYMdlTSTqc3oZjBm9GNd4Q9xRB4ddAOk=;
 b=XQVjrylvY8vVLmoLRKVxgmDRCVPsFaVCt/Gmfh9MQJqXDcH0N8MRBCQMCteplc2xESe5vxZtaWIYvImHkZ5JUi7S/83DY7xhX0+7VVWAgA8MLz8VSdNqTICkcYhQlQfE0SJQ0bJEIawehXUE6gD/hQG+8Vl/P38jdsgKOxfnnWVKMYwjZB7lkI40dS0fEA5mK9wHNSacsGxoBEnZ+YXDmHUawQqayu18XL5CsKsU5jLFZkpTIKwQPY4pwCgk41K1UHQsxrF073/oI05gl9aeDWpw7QHq+15eef6MCPjKGN3hZGrmBNSAtYH8uKarLAM3htFYmPVXygNs7dmJQznFvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:06:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:06:01 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:29 +0800
Subject: [PATCH 2/6] phy: phy-can-transceiver: Add support for NXP TJA1051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-2-c075f702adea@nxp.com>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-0-c075f702adea@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=831;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aC1FGcVpSkpo43sZ2H7cHHNebZZp+76aQpe1j28Lyh8=;
 b=0d7COwJ4/U2S05/rNqgjhqMg/6TJhNwzcT6xV2j415j5EWUAJjpB9tcsyz4zdmpUVb5nHS1dt
 2EKwbGIO57+AY4VYZnUpxz3ZA0dEJljK9DX9KPqju32UA0KqiXHzDPu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac8aaa8-2885-4b45-2eb0-08dde13134e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJxME0vdGZveXlCRDBwbEVYL2czam9jV2ZiaDIrRUI5TG54OU9qN24rL01B?=
 =?utf-8?B?MW8wQlp6a3hhVEhGT0tMdEl5YjZvWW9OWHZibThXeG11RGVDZmdlMzlXbE90?=
 =?utf-8?B?c2d5d2xoYnZaK1Z1Y05Ob3p0bGlOTFlUZmJuRGFXczYwT09GRXhKeC9ueWpu?=
 =?utf-8?B?UG1Zancwd0NkTHR3ZjJBRHJmL2NROG85YkY3cHA4V2tSVGtlaFFXMUEyUEJX?=
 =?utf-8?B?aDBzV2FIemQ1NGp3UWMzSThXR0hjU2JnVXBPRW9hSG5DalJkVTBmZU8vY0d3?=
 =?utf-8?B?OGZINEVmY2x6aURucnhIQzBwZHFvNU5rcllwSXFJczdwek9DdmJHck5EckR1?=
 =?utf-8?B?QkhibXdwQmpjV2NZU1FUUEp3N0d1U1NiTTNGaXdsL1NPU0l2elU3UGxGS0ha?=
 =?utf-8?B?WFZpZ0tBQkF6QXpwb0ZSWGF2Yk9MSHY5U0VBamxpeEVTS2UzdHh1SUI5bGtj?=
 =?utf-8?B?KzlVcUorZUNmeGlOalZBWU1PUlJVbzdaQ3QxYVpWREpaRXFiNEN0WlZlYS90?=
 =?utf-8?B?UCtpeTRoNzNjbHFsWTY2OWxiTDkyMm9JOVhGYXJPV1Q3Zjh0ZmtPYjRQelRT?=
 =?utf-8?B?RVZqaUlxbmRmM3M4dlNGV3FzQmdKbkhhYXRVdW5FUG1kMno1OHRrcWN3ZFM1?=
 =?utf-8?B?bWtKRzlXQXY4b0xoZVdhN3ZkUHBhZ09qdnI2dExscFhiMXFwcDhGSC9oUkQ5?=
 =?utf-8?B?ZkRTb1lUZW9RRHNXK21YeVlYYUxFNlJhQnRxTE82M0NWRjEvdXhldGtiZVVt?=
 =?utf-8?B?R3lKVzVSdTFSc25lT0pOTys4S1FIb1BGeWpyL1NsSlQ3d0VUQW5zMkdTWXlP?=
 =?utf-8?B?TlIxRzdMQUNCZWFNWjFVaUNXaUFGL1JnaENqZ0hKenRnZUlxOVdyQzE1WWxl?=
 =?utf-8?B?UHBDeElNRmRLSU1TaURrVWtoNXk1NkZxaXc2WmZYKy8xUlB2akZjM1dBOCs3?=
 =?utf-8?B?cWltWFV1R0hZZk93TUpSVDBMdDNNUTdEV3RxL0tOTVEyUWRLZXpnWjlXOE5j?=
 =?utf-8?B?cVJnSDN5RDNDdmZJOHdlMEZXYStWZGU4cXpETDhJZnEzU0hmQXZDd1Y2ODVk?=
 =?utf-8?B?YjZBSEF5cVJjQjFmQ3RPeFVrV09CUmZ4Z0hLS0pBL0c5MU5FajhsZ0ZpdDJz?=
 =?utf-8?B?RkRqQUswUFRGdW5tKyttSzZYMGJDZ28vMzlGRTZGRjRzOVdaTkp1aWxZV2pN?=
 =?utf-8?B?UGY2QzVibGJuT3RFdzA0ZTl5bXNHQXZlWHhXUjIwUFREVUt5SEZwOXR6NDVa?=
 =?utf-8?B?NTdsNjNiT2xIYjFFY2hwRDZSNFhzLzVBKzVwcXpYNlNNaGRvb1loSHdyNTBy?=
 =?utf-8?B?UUM0aHJoMjFNZ3orK054T0crYWI4clE5R3Y2S29KbnJIeXdibGpOb3UraG1l?=
 =?utf-8?B?eHZmYmsySy8wWEpxdEVNL0grb0lvS1NrSFd1TVpKbGdqcURCeDY5ZVM4UlN6?=
 =?utf-8?B?YXhia0ZrT1duMTlFc2lpa1lBQzJ1dXZhOHF2WGtoVUpFTGt6VDdnM0crUmU2?=
 =?utf-8?B?RWhGTzZ5OVA2YnBvVWZkQlhUYTBOeWxCU3piTVhmOGZqZ3ovb0ZBcFpEWGda?=
 =?utf-8?B?L3VRbzFrdU5aTld4R1VpRXNvUnAxQ3ZtajN3R2R1RFpSVm53Wlc0SWdtUFda?=
 =?utf-8?B?cGFocElYaGpRcisva0VFckYrdG9menRmYVNkekFxSENkQUdjaXk3bzNCS0VE?=
 =?utf-8?B?ZGRySWRRUEpDaHAvL3NyeEdVNWIrc0F3NWVHaS9DVi8zVUZxVkliSkFoWHo0?=
 =?utf-8?B?b1BlblQ4MGwxUG5wNEcxSDgxMXpYZVIrMk9XVG9MWFZKRGxjQzRJU0lsRVBB?=
 =?utf-8?B?THg3UUtua21jM28rYWNuNUROajF5MzgxMlNEVzkxNnBBWW5IcDI1MnlYS3pi?=
 =?utf-8?B?ZlgrZWpJSEdvVzRCVEZ3cDliaG8xOFEyenBocWJZN1o0b0lUaXFzc2swcU9W?=
 =?utf-8?B?ZGdqQmplelU0alUxVDRnMGRvYzlOMWJWelBUNTg0cUE3VUIxVVUxbm5tcENU?=
 =?utf-8?Q?DxUx7ZckxzSMsxQy/F3m3Uw6g9mPxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxhNG4zd3A3YWNmcjdFbW10U2lIVjgwNlRMWXRoVUtQUVViRElDUFV3Q0l4?=
 =?utf-8?B?N1I1anR6QWtJWndueVkxalZlbXRvZDVqU3FOTFVRKzdNOXdvNHdsWHNKYjZJ?=
 =?utf-8?B?c1JaQzNOK2trUmNaS2Y4UmExdk80MWt4RCtvL3g1VjI1ekh5SnEwQ3RJWTNN?=
 =?utf-8?B?WGRtMkZRbGk1SStRZWxaRmJ1MDhWRVlHQWtvcGlWZW5BaTJCZVlnb1RpaU13?=
 =?utf-8?B?V1NqK1pYazdUclhBa2UvV0hhSXIxRzIzckg5Wms1VFIzc3lzT3F1NUNZQ3lw?=
 =?utf-8?B?TjcvdFF4aVVGN2xwS1NIUnlMMDFLVWZUbjFIY1UxUVBHK2ZtdFdrSlRVQStS?=
 =?utf-8?B?SFhWSXpBK2dhUnlvNE1JNlBoMmlINmdIeVVSOUdpV0k3NHVyeEJYdk05cmxY?=
 =?utf-8?B?NVAwdHQ2QjVPbmdBSnl0bElULzY5d1dRUnZzdUJicE1GS29sYUV2V0g5bWU2?=
 =?utf-8?B?clcwc1FEemRDUTFOS1IwbVFaWm91VUFRSDdOY0xZbUV4N3E0ZjJUaDg1RkF4?=
 =?utf-8?B?cjdRR1ZBWGRnVEtRbXhqTENmNDdxd0MzZE9uR1FBaXVDb2dZOFRUdUhxUmIr?=
 =?utf-8?B?K09kWXBvdXUrUHJ4TUhWbEhOZmdHdzNZRm5EQkhLUktmUElWQlVvdTZwYWxh?=
 =?utf-8?B?SmE0N0lsRlhWM1ZEVE56ME9oZStEcEVwaWRKYXB1QXlyRk4yK0FEZEtqMFNT?=
 =?utf-8?B?TGdDeTIxYWRiTmlrNkpoZy83OUphemJIVUQxZFNOVG40S0s4YjVNZmY4MWlI?=
 =?utf-8?B?bGUyRTRxcUVNZSs5ZjdBekV5NjVIM3dTaGZmQ3lPVFY3MitwZG1jS3VpdXJu?=
 =?utf-8?B?WEp4ckc5SUQrUnhUZ0ErTS8ySGRTbmNoV0NwT25qeG5FNlBSLzY2N2RiWWdi?=
 =?utf-8?B?dmZ2ZjVHa3F2YmlVcHFhUHk3TmF1WlhJdDFWSEVYS2xMMHY3RUs0TGhYcTY4?=
 =?utf-8?B?cnA0MmgxWmxFbEI1cWFtc0lUcEFMY1BDdXVwMk1lL0U5T0hYUzBiTXhmVmlK?=
 =?utf-8?B?UnRpY3ErK29KbTQyZkpEQW50WG1PQk1LcmlFTmw4QTQvSUlINE1PWE1TZlRo?=
 =?utf-8?B?M0lJaFZvWUt1T1c1MEVQbkVIMnpmeGNnazd3azlXVTI4NGJna1JMajM0RnI5?=
 =?utf-8?B?UFo4Q1MwSWE1WlRoT3pmTmlzVHUxTWZiWVdhUjM0OGNzU3E2STJWazhVRFRU?=
 =?utf-8?B?NnlkOFRHQ1RvMzB2R2NoaHo5ekpRYUEvby9oU3lnc2xNTnhWT1oxYi9wUjJz?=
 =?utf-8?B?YUtDUUFIZTN6cEs3ODB3RGcxWHpUWDFtOVRHUkdLS2V1TzN2YVExZ2lWTmUx?=
 =?utf-8?B?WVV4TDJTZGtveFJGMFNsTWdadmNyM0R3dnczZGV0bVBTZlBwbjNkcUJBTWRu?=
 =?utf-8?B?RHlQUUw3enI5aWx6NHlFRjZnbkJkZDQ3OWJOVW5ZWklHa2ZmV2hTL1hnR1BX?=
 =?utf-8?B?Y0QyZytKdDJZQ2pXSStKYlBWTHExelFIMnkyMXJUeU1XTkVZVjYxN1R2dUNx?=
 =?utf-8?B?eitkTlVRdjNiQmdJck5zWG9ieUhWLzhMNzg2Zit0QUc1ZXdCZmVLTi9DU0d6?=
 =?utf-8?B?azFXQk43MEdEQVlHVy9wM1Bza2UyOUYwbkZvQkdscHRKYTJ1QnBabUJONlRk?=
 =?utf-8?B?Vlo2azl3ejRtK3FXYURNeDNGMHhKQ2ViK2wzaWwyenNGVllhKzB4V1ZyRnJn?=
 =?utf-8?B?eS9haXV0RlNpeUpjVkFxLzlNRmpaTHJleXQzN1BMRGZzS01pUWRVTWU1ME0y?=
 =?utf-8?B?RE9uVEwxZG1WMEJVQjFScGJ2UVc4dUdYYVk0QlBxMTArSjFxMlBJNDc3aVkw?=
 =?utf-8?B?TkhITGRZc1QwT2JSbmlwVnV6UUJyQURLSlR0T09GeG1tZ1l5QzhvYW5vM0xB?=
 =?utf-8?B?dlJCOW9xTzFmM2lnNk40YURrZ1VQNTN0cU9UcU1GK0YxT0ZnRERRT1JBNFNV?=
 =?utf-8?B?dG92azdHWkVEbDZ3SVN6bGpJekZtV0h4Slp3dkR5YmRXWklMSU1mTlpRUTY3?=
 =?utf-8?B?dHQ5bVp4UTFpRnExb3pIRGpRR2dZU2U5dy9PRWtsK0VaLzFQZVQyZGRIa2NO?=
 =?utf-8?B?cnZrYlBOd1Z2RmR3MTc3ejE5UEVaNjJnK2hMMGs0SWh0Ui9Qc1h1QzYzMEhr?=
 =?utf-8?Q?5Ur2gKEXc1FGy7uXjIcD8voK4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac8aaa8-2885-4b45-2eb0-08dde13134e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:06:01.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnRc9beea9v8jhrMF2mPleLYk+4X7lpHK7SNx1y4RuuJ5MogV41SqxvRn4MYohlB0PN7NH1bIllS06KqPsIpPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
alternative for TI TCAN1043 with Sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..b49371a1272cd8a25b5e2271586b756103c64f0a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -85,6 +85,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1051",
+		.data = &tcan1043_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata

-- 
2.37.1


