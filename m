Return-Path: <linux-can+bounces-4537-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF2B4A15D
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA880447987
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581013019A7;
	Tue,  9 Sep 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hak9Lxsu"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E042FDC3E;
	Tue,  9 Sep 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396473; cv=fail; b=JKzHEN+XTngLV7EOwu2lVngp9lWz/wRnfIhQCCCv4poV+KhJbwy28MtZvtFn1OaMj9Dgp7V+F34/k24s2+zNqiUStpBjC7u0U3hcf14xgPgfhLBZvdSR/vZzZ4HI5tsQt4sfHB+16hL6nAtOdxl2+LMEhYfQvfzgfrYto6ZXHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396473; c=relaxed/simple;
	bh=ZME6NSbD6S+dhJTbiPxWbLml08PDlkhIEqUD0mxIBEE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G2DH4sXU1Qcm/IxcmnAvJrBH263jY1mDW/rjhCD9UUVgQKmkrRsAenOlIvlILrBrne7koct7MXE38Sqqvvy3xvk903Thk0F4Z3KxGPytDg4rMeKvXY9d40a4d3H4g3nP5yOoo2lQJbwwwu/1ub5IXkrJaoqmJ54QhkzetOUwBPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hak9Lxsu; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1Go1FthCRtO1SqM4PJNxzpe09Ds+aC34HdRc939A9QedAZA3+5HPurwv0HREjyCuqc0iptEXLfz0ZU5NDSOhNazTXF2nRLBnZlx28kL1MZTeT8imdUhCXV2F0gzAZG8q7fu6QxdlhlnLYcrj16Za9YEia67F+eAL2nLRCfXmhxU5+5wbxp/IYc+I9hCNFXMSm1UJ57os93OzoVTsVsdsB7xJwT1dUqWulemdVeaONYwHi8CiD5L2BipBrRBNLnr3TxCuIPFXfVQjNLkKQqPoJJhGO3E78nTg+YztCAzpVBvTDrYCG1D4/3jFI/4wa8iV5AlKwTbihpLg9+UwW/eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9MauOqyJ5hgRky4mIytzekEI3p34oKKh08oGMSNpeg=;
 b=aUmjT283OLAusVEFTO10OsuuqOpZ4FR0jayO4QdVJ8NVdDmyByeg1QEpNOjSD1QP/YDcwXVZ+D26dh2PyaUGZzpOq42nbzzG7XMY/YAeB2xCnirEWyw884sy9zB0fyqMfRVRzaxjy0t4SIbfWvw/sKvUH1CB8t8qzIOSjh6OJtqIbzV3Q7ZcnH7SMx5XnjIccqi9sVvxeSh6rR7pTN1HzmKDdly2lAIcN/cYPzPmLhFY9IY2hwr1J3DB3keFWd7QLQzPox0WZ9d2HPhnglKgAW7BgT0hxAPc70DMQtpxfm5KNp+NfZdcFkVieTWnyGQbcvRVeCKc1GxLCRdDe4FR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9MauOqyJ5hgRky4mIytzekEI3p34oKKh08oGMSNpeg=;
 b=hak9LxsuQG/c/EBZm8JF3n0xEsdLue73yLxpkWxKCXb5D9kRZf4EVxgmimc4KjrhQWjXKXQ3ebcs8l1avbZdOU1iORQDAFx2pG8vjSiwuaem7pmn9HocFTQvh7LLNAttChSsFiqmG/eEccb+WyC1J4OvrCQCEzMI3KNmcRpuVNlsMCSy72E1S347cPZWbNSYEVTARbYc7u8THZwxqJzNqHeln2kW1Pg5sGKE3CwgMy3ZCaZABgz/1WcrhmyBPO8jHQa5zJDCjY9KIwBwJv7VHxTUDH+59fqLSPwR1Bbv8crLCn5AZlTN7CGEZr9OV4g/89IzHmuTgR8ebcBodw3Wkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:41:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:41:08 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:16 +0800
Subject: [PATCH v6 6/9] phy: phy-can-transceiver: Add support for
 TJA105{1,7}
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-6-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=3647;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZME6NSbD6S+dhJTbiPxWbLml08PDlkhIEqUD0mxIBEE=;
 b=9JMe5sSIm5IpEOJjLMFR46EsZI/nNbK/KzZopZ7xRB9poaZRTGcvsIq67Eg++w5D/WjrQUChJ
 gH61P/VFfrCDmYmjkK9m56W0MBGj8ITxQXBDre9UUQq3qQ2QlbtXaWO
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
X-MS-Office365-Filtering-Correlation-Id: e380025c-878e-498f-5877-08ddef637a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRYbU5BM0dxVXdDK3JJUm9OMXU4QWtKMk9PL3ZxWW0zV3g0OGp4RlFCOHNB?=
 =?utf-8?B?UXArdmk2MWlrT0I0czBWY0lsa2wySEtrK3dVZFJiOERzOGVxUlpFQ2NMRXpV?=
 =?utf-8?B?bUtheWxEYXRIclRmREU5bFR3aktBd0VmZ054UGpoaENJWHZUZHhpMys5NktZ?=
 =?utf-8?B?eEpDd0VabjMvZ1RWaUpYakR6d2hLN29ZWFJTS0sraGs4QkFGcUZqN2RBQWNa?=
 =?utf-8?B?QjN1QVJtY2p1d3lKL1VhbkJjSVVyZHpOVExkNzlpTzZpQjRyNmlLOFRRNlpF?=
 =?utf-8?B?MFJzRzFsNUQyakxpa2lubTd1bGxKcEZLVVA1QWtkTCtORkZwaitYZmVmRDdN?=
 =?utf-8?B?WUVMZi9FVUh1U0dDWVdycjkwNkI4UzUwc1ZkeGdpRjd4OStldmZGRkxEL1Bx?=
 =?utf-8?B?U01NN2pDOURIYnhoem1qTHJ1cDB3OW03REp2UmtJMU9yZXdvdDRQbmJCREYv?=
 =?utf-8?B?SDVHdytyN1VPS0NGQnRrQmJsYzBPZTRTZlpZN3pNMEc0Znc1WXNRajhRZUdL?=
 =?utf-8?B?R1hHREl3N05ubGJCdmxjdFZJVlh5K203cXNvQUZta0o4cWR5Rkk5b3Jra3hO?=
 =?utf-8?B?MERzcURnUVp6QTIwNFlaK3VvR2s0MmR4M0RsNTJDRGVEZVRXcmNCQlVVTXl0?=
 =?utf-8?B?SEpoWWp4Zi9sYzU0VVI0cW85MkFaUWJwSFAydFZqVkJkZkhsc2RoRGlWc3dh?=
 =?utf-8?B?Y0VIbHhmdUdlbkZac1BOMzk2bHU3VXErN2xVR2dwOG9wdlVMNFdNbkN3OXNm?=
 =?utf-8?B?ei8yMnlPcFZQOHVJY25mZENBVjJLYjBBQTdGY3I0LzZnYVZJQ2NXcnNDNC90?=
 =?utf-8?B?K2k1STN6bmp4d0ROUHVSN2owUUVVcnA4ZGRRTGorOHMwYlZYdCs5R3EwbWU4?=
 =?utf-8?B?KzIwNkM1cjY0SjBJVDJ3VDlQMGdZaDVYcHpETFYzeDkxYkIreXdIQXczWWRn?=
 =?utf-8?B?bGFOYnd6WHJpVk9ORlZ4UTlVV011dFBHemtIS29LSGRwRldnejNESUVQeHhp?=
 =?utf-8?B?NTZaUys5MEkrYmdKOEs4ZnVkN3JUREFESEg1UWQzRDdiRUhHdmhVNitIcnU1?=
 =?utf-8?B?bXpkR09nQnYwRVJPZDI4OG5kUGg5VDVpZVdJSGk2ZDhiUE9NaEo0MUkvUWlt?=
 =?utf-8?B?UG5DNHlnZmh0cDkybFIvaWF4c1FlY0pRc2c3cGsxaHZtOTdMQnVsaWdIMk91?=
 =?utf-8?B?UHhhQjd3L2dJVWJUcXA3cVhMcU03dGY5M2pkYTRLMnUybWxOWlNSMVpsOHQx?=
 =?utf-8?B?U1RhVm52UkJjSEYvNDFXdWROMmtldFJUK2JZQjZ6a2gwVnBiZnE4aGRZQlR6?=
 =?utf-8?B?WFV3Qnl3WWRLdVpGRXdaRmtZYXRTVXFyS2crYVhDWnQrSVdqUytLRmloSEZR?=
 =?utf-8?B?Q3REZk1laUJzM3NOMXNrajVvTHdtaHg3dFEyTysyVnUwbE8zQTUvWFFCZ2lL?=
 =?utf-8?B?Nmg2MTNoSHRMVFdzU1Q4dWd0eE92bVRwdjhGMGR3MzgzY1BVeHY0OGdRaXkw?=
 =?utf-8?B?TmxMUFllV0gvRkNaZExQeEJEbS9aQTcxYStueGlPTXFDMkFIa0loM2lHNHJL?=
 =?utf-8?B?akxoS01Ud1BMNGxSdjZzME9sWTRQaXhadW8rTXQ1UWMrSHp5ME9Gd1YxR2Zy?=
 =?utf-8?B?YXR6UFhOVE5vbVNWMUFocmxjdGdwZlBZak5SSlR5OGphVC80anRYK2pKY3NV?=
 =?utf-8?B?djI1SmdsNFErZm45cmhDUFI5eGpJRk5rSGJFTEIwc3BFa2dHakE2NXVJKzIv?=
 =?utf-8?B?ODAxaEF6elZNRk0yOHRqSGhHaVlHQTI0ampRR3RPYVFUMHJWV2NjbHNqKy9z?=
 =?utf-8?B?SmtWZ2Zud0hXZTFMTkcvZ2doL3MvOGFYY05Tdm1tWjJoSkVydGhqRjVGSDRR?=
 =?utf-8?B?VXVwVTg2ZzFrVVdtb1pTVno1TUgzTDNaRnVXZklTNDdlWXMvdUdBYjdvNUJ1?=
 =?utf-8?B?VkYzL3RzNmlBR3lsMTRoNVd5azB3UVRESUFFUEZPU0xaNkExeEkwUVUzK29o?=
 =?utf-8?Q?JkePbG40i1a299t5Y+JG945M5TeAc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTIwckM0ODUvbHZ6Z2VwN29wK0Z1VUszS0o0NG1BZmFmRW9lenhJMWVtLy84?=
 =?utf-8?B?UC96VFhxNHFpMmFQWGkvRTBTc0I2ejNHQjZkbjVWcDMzYkQ0RVBRZ1Azd2gw?=
 =?utf-8?B?dDl0UVFrWUI4RTMrNUdjQTlqa1J4K25nZGdrZWsyM3BaMHY0bmkyNWRHVG93?=
 =?utf-8?B?SWNOUUxjOUdpaVZhRkszWStVWjlxSkJKRUl2NHF3dkxZUkMxcXNuWXJCNWpF?=
 =?utf-8?B?T2hYckZIOEJIR0JDWTQyYXF2WEtrQ2FVUy9CcHV3Y3JwZmxtNGlJa2laaXJG?=
 =?utf-8?B?RVdKbER6ZHg2ZUZlM1hEaXl3a3MycmhrL0VONHJMa0ZBOUUzWEpYL3BNZ01t?=
 =?utf-8?B?aXJGWXZVVHJQamxGR05vZm9ZRHUwSlFHMUpERENTV203aThsWlhmQTFIVkV3?=
 =?utf-8?B?RGU5TmpHL1ZVWkcrSWpxOWwzbkUxRi80MmtwSmFCUkVWZ1UwMlhJRk1tdmlh?=
 =?utf-8?B?TmpGSUUyS0d2dXJ4R0hqTzJPUVpadjExNG1yQ2xVbVZtQWVMeFdpYlRyYkVC?=
 =?utf-8?B?MkhHSjNneGJGOWFWQ2I3NlAvOXRkK0R5KzJ0UTlPbG5LbEFIbzA2QnlJOHIx?=
 =?utf-8?B?cWlyaVVqU01Ydm5ZUWVtUFNoU212YjMyc2Y5UWkvV3JNWTRlYUtmNmxhVkcy?=
 =?utf-8?B?d1VKYmxHQTYxUURZamJrdUZOejdrUmlidEcwZHlZQjM4WjJocGl4Rjg0dDgv?=
 =?utf-8?B?c2YvREJYM2hVMWUyNSthVFlzTDhsRW5oUmZrYS9QUUpybGI3YlJKK2hSK2Ft?=
 =?utf-8?B?c1NTZkZJVUR1Vit2Q2FlMERsZERlWGViQWt3UXlVM0NuT0lYbzEzbWowNjVi?=
 =?utf-8?B?LzNiM2ZuTWxPOC9teG82S2VYc3BFS1VvdUhDKzIyc1BaMCtqL2w1L3QrOUl3?=
 =?utf-8?B?cU5OeERYSWlnblhvcFNsN0Q5dDhhMGFoSlFmd0ZUcUJTWmFLVnVUcVgzNjBr?=
 =?utf-8?B?R3FBcVo2Ty9zbjgwOVA3b2YzWnRBK25qRzRNMEtLVVhJdUF5SHdJdkR2MTJr?=
 =?utf-8?B?dWVqTlF0TGE0K3VZTmJLSnh5dW96NUY1azdDUmJRcm42ZzIvbWsxaXp6WDVL?=
 =?utf-8?B?elYzUkNpd1gxNG41Y3FDTTVEVHNGTnAydzZUR2FzV2FKcU1mWVFRRi9RY2Zh?=
 =?utf-8?B?TnRoaFhxdDE0S3EzU3ZBYkRrU0Rsc3NPaFNMUkJLcUk0VDdBTnUvSTBBR2kz?=
 =?utf-8?B?VTNwNS9GQnJxM0g2ZGVEMHVDczNvMW1EWWNaSTh5Mi9EZTZzVUJnWDFHY3Jv?=
 =?utf-8?B?VGN5dlZEbEVGMWtuV21QUlpxbWswU3lzd0g2MW5pM1lmQUhSLzhGeStnNjFm?=
 =?utf-8?B?cnl4VGVDTGJtbE84M3ZjOEIyOTA0alVtakJ4SDhnN1hwSWN2aEgvQnM3cjQz?=
 =?utf-8?B?YVR4TEZZZERiTGVDamxpbGxhN2Zsa3R0dmNRbVlGa2dPSml1ZHZ4WWNybVNU?=
 =?utf-8?B?aFRFcFQyVE15MHd1TzhNOTNVU2JQOXFDWDdwdmFRYTE5eXpYL3FpdS8vR1lz?=
 =?utf-8?B?Y01DSWYrM0lubzBhaGVXR0M3V0xDRG9LZ3pnV0FGRmdUb3dLemRMK1k3R1Bn?=
 =?utf-8?B?WEdyKzQydDZTUUNnZkFtMTYzNW1hKzZJL29HRHpnRXA0Y1E0bldkeitVa3dV?=
 =?utf-8?B?ZEdsUWZWTnhPTEpBeTBGaFRoeGhQdU1hN1pBWHEzZGN6M285Z0ZrRUpoeXVn?=
 =?utf-8?B?NllIdVNaaWp3U3FoT1RuQjk3b1hVNVdUQUNsMTRqWnJwelp0WlhkWFBucUFJ?=
 =?utf-8?B?MVNtRlhTWWt6Q254bEhLWllVZEhQeWdlWkp1dkFtUnR2bzUrcE5nV3Fuc0t5?=
 =?utf-8?B?YVdvWkVWZkozVVl3aGVhbjUwUldEaEJSYXVFWE9wYm5zSkFaTjVGNGxtTUdT?=
 =?utf-8?B?Z3lOalVyZ1NDckVKd3dLNzJnd0NjdUNCTUorYjJRT2wwT1YyT2d5K3ovTlpB?=
 =?utf-8?B?U2loVDlYR3RCUnkzQXhYOWR4MS8rdFgxalF1Wko2Yzh2SXFmcjJkN3NCK2xy?=
 =?utf-8?B?MnBEVzBSeHN6TGFGdXcxVXJaWE5wczZjdlhPMG9JbVE0c3dHL0d2RkVlMFQx?=
 =?utf-8?B?YzQrQ3RXRVVPdnJjbjYzUTNSbGExNXFhdmorUERtcjFqUG1kMzBzSXh2Y0Ex?=
 =?utf-8?Q?2NCX6j+yKCFszstj0W4tJo7V3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e380025c-878e-498f-5877-08ddef637a21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:41:08.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGnmFw4kE4+d5tErrIm1nJMDeY0/6IU6rYp1xseF1dM7eK/bvRy27T45t/pe3bB2I3PAI1v6Ai6vWFdWm3ViJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

Support TJA105{1,7} which are a single channel high-speed CAN transceiver
with silent mode supported.

phy mode is not implemented as of now. silent settings are kept in
phy_power_on and phy_power_off. After phy mode is supported, the silent
settings could be moved to phy_set_mode.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index ccb29e1dfe0d07005b4bcd8fefa2787292d921a0..d9fd3564970695d5460ffdc4e8636dd7638d64a2 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -18,10 +18,12 @@ struct can_transceiver_data {
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
 #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
+#define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
 };
 
 struct can_transceiver_phy {
 	struct phy *generic_phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct can_transceiver_priv *priv;
@@ -47,6 +49,10 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 		}
 	}
 
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 0);
+	if (ret)
+		return ret;
+
 	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
 	if (ret)
 		return ret;
@@ -60,6 +66,10 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 1);
+	if (ret)
+		return ret;
+
 	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (ret)
 		return ret;
@@ -92,6 +102,14 @@ static const struct can_transceiver_data tja1048_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
 };
 
+static const struct can_transceiver_data tja1051_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
+};
+
+static const struct can_transceiver_data tja1057_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -105,6 +123,14 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "nxp,tja1048",
 		.data = &tja1048_drvdata
 	},
+	{
+		.compatible = "nxp,tja1051",
+		.data = &tja1051_drvdata
+	},
+	{
+		.compatible = "nxp,tja1057",
+		.data = &tja1057_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -150,6 +176,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
@@ -213,6 +240,14 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
 		}
 
+		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
+			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(silent_gpio))
+				return PTR_ERR(silent_gpio);
+			priv->can_transceiver_phy[i].silent_gpio = silent_gpio;
+		}
+
 		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
 				&priv->can_transceiver_phy[i]);
 	}

-- 
2.37.1


