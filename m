Return-Path: <linux-can+bounces-4389-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32202B3B3EA
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E772F176622
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10526B760;
	Fri, 29 Aug 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cl5Mx38c"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534C26A091;
	Fri, 29 Aug 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451400; cv=fail; b=LAFsiqOLtgvnhsI50JUBLt+E4vys8AzgIzsaNKj7oSouU+PTblqgpm4nvf+8WTZruEcYpmav4w4NJViXwjpoh/3j1Yec9MGf4CNRTiJl2wkhz2Y85NNpGdLEvEDQ9vZDT3bZA2peJhtCP6D5E2eI/+5PFtYF6wsNKzM0E4bg3dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451400; c=relaxed/simple;
	bh=VroDYWIDIizoxCF7Eth+wQvJHXPETL5gg7BJJ4hRZvY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jxG6ZcsZGILAyA+AzPASlpB44X+4v+ZRl5fn7tATGdTBmTf+PST8rytG+pWBY7vFgWOVUl/LAat41PplZ8AGlI6LoIam80j9W5OHCgX5q0qTSNB9YWm1jYqXcyRbWTNpTD9Ar2FNelNpaWv511jufT7CixMVjo/O8dSyQEfG23c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cl5Mx38c; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySF7L7ESFxvSEdzZUYRx5fJnmje+lIDZDN6fmo7WxaIl3TgdYvllO6L/4IRTCDz2+1IIpE81sYJ7SF1uuaFgnNV9llJimQErVO1tYAQatqKdMBtmXsQ/+Jncy2ZBc5FmjquMkMnJIQEk9icm1aK7qbLvfaqSax+7o2YGbJ+xzobly9/8GnWrejBHDB3Sw2IF5iOnBXCjU9vCE3E0FoB6HeCSFSu3/swqm35hOzoIgwawiGWGNAxMrBT+4hUjaMbKEAuBk5SiIzgaNhgbCwDyMUyJwwfTFUglWTdeq0v8STzmOX2RBmKt+VN3z4bex66GrNEKLYMXb42IY4zW5Rt/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUDEV9D3ik+iKLzqfeyW5Ncwy0XBCW7ukTe2ghhf5mY=;
 b=GhAfRHXUSwmjLw186pJPEReda2W5fLPeGzV0lOc4bbZQL/4rv+PRsF0L9QGNUFodzCCiqIC4Q4jqQFhWHbK/n3h203xJmtfy3gq+zSkaMOtIgSpD3Ax8xrptPWh7OSYqNCehRkcLl7auR89zFMZ8nnywzGC1Xaz1QqqJ0ih+pMM4cIep/0p9svsW5TdxTuoSvpq5Q0K7MCXeY4+w/ZyK9sTDJ+s8Zu3eAFSfYOfDmD4iWQ0RmnQ+FtiogWBtU23hP7rDWWeZV64eVshXdVcYQyG3C2rYExkBoSBAJTmk9x3TW7pbLyW+NCWMeh9E+BOZcW3rYDECAAspD3V43yDQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUDEV9D3ik+iKLzqfeyW5Ncwy0XBCW7ukTe2ghhf5mY=;
 b=Cl5Mx38cTHVriR4AH5GOS1W8TYcikZUEjz2IJg4iIlo9Qatjsb83GNVGAVALxU8ZlwyycW0EFfrTBkZSONLt5kotzDMvjjbiZ++N1IIXIi416C3kpj+Ck5yzpX4Sd2yLKQg/37fWXzqOD8ipm9anP66Ephs08p+gYdqM/KOF41tQZUrDGW32tkut+h4AuDD6ly4ryhu4qEP702meG9RQ+XWVRFBB8SDrLFxLRZ7lF1PfsBPSwBLJ7bqUgOFvywftjD0h8UfCBc4I6jr/AD2MnsfrOFy20WTHszxG9W6s5DSDmN6i5wkmsS6YI7b1qWgcSG08deT61BC7iwDOurZ6MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7752.eurprd04.prod.outlook.com (2603:10a6:20b:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 07:09:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:09:01 +0800
Subject: [PATCH v3 6/6] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-6-3b2f34094f59@nxp.com>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
In-Reply-To: <20250829-can-v3-0-3b2f34094f59@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=1669;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VroDYWIDIizoxCF7Eth+wQvJHXPETL5gg7BJJ4hRZvY=;
 b=Atgl+ncF1t4faD3OS0vVdIkSDynnb/f9Jt8t4WuM+6hG7eowCkOwxbkIUNoj06UBhBw4Emqdf
 a8jkfkFwb/pAP7v+wY9injgYdseknh8V5YEat5FO4CZboX5DNT5E5Rz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 9072075e-a913-4518-0c75-08dde6cb0e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRxWHA5WFNWNXIzSERqQ254cGNESCtUYXJYV3V2a0FLbW8vbkMrZTRVUVlI?=
 =?utf-8?B?WmZ6cUs4cm1jN3ozcmRNcWlaZEFFNCt4THNuL0lDWG53MVV1RFZkSENXOFF6?=
 =?utf-8?B?MExGK2h1TEI4ZDRsWmlsTUFxVi83eTBieU83NXZLYjZtVHUxek9Ea09JQmV3?=
 =?utf-8?B?ZEVEZzlETm5YQlRxWWNad202REFjWGpWN245VnA5V0pSajJXZ0ZJK1lZb0NF?=
 =?utf-8?B?Mkx6QXFKN3JkaHRXT1pNUFhVRTBzYUtEaldHdGxMZWVBNThad2w5eEV4RThj?=
 =?utf-8?B?dkRUeFo3L05wZURoNDdiVkQ0WWdUTEcyOXRua1o0dHlrRmNMMjcrMFdtT21U?=
 =?utf-8?B?V3VZNXdpRCtXRUZHc2swNjY0WUdjdHRYM3cxMXJ5ZkUzdHRzMXcyOGxyNG1D?=
 =?utf-8?B?Q0VhTXJRait1SVJmUlRyd0dva0N5a2lDQXhOWmJYTXZsaTFmTjlaVC81YW12?=
 =?utf-8?B?aWZEMnhLRHMyaXdtUDlONjNjd0JPSWVaWHZTOE1DMVBDN0c1L2IvdFArTk9z?=
 =?utf-8?B?ZURiMzdwYVl6MnVuU2tkazhzOUtwU01ySE9KaFppQXVHdkU5SUZGSXA0L01z?=
 =?utf-8?B?d043L0J6RTU3Y3FMWnY4T0hNa1BaQXoyY1NZNGpBZHdGSHpNSzJpTmpVajBq?=
 =?utf-8?B?eXZxK3RjU1dEcVNQY3VNWGcxMjdSZFhSSm1nOEFsUnNuZHBYZy81RGc2bzVN?=
 =?utf-8?B?dm0yVnJuMFEzNGRQVEJGRTBibWx0L09ORVJHYWpRazI3eVV6UEk3cHhnWlpM?=
 =?utf-8?B?S2hhc2N2eG5mWnE1Tk9yL0x5djNhVVFweGRhQUltTkZld3lhN2RDTlhSczhw?=
 =?utf-8?B?dzNTcEdKNjlJL01aTmV0MlBEc252a1lTc1JBRTlzQXVuUnVsZmVqTTNYL0V4?=
 =?utf-8?B?cXhIUzVveTFmM1cvL28yVTBoMVVFSjlYNWNnb0pkY1piQ1oxc2VHTGtLS2FY?=
 =?utf-8?B?UkNYVnRDWk1nUUE0SVF4emFJYkF3Q3g4VkovcUpGcnlQTEJhMDFOK3dsY0Jh?=
 =?utf-8?B?ZjFKRU9zbU5DbldLV2ZkcEVhSlBJZ2ljRE1FRm1kTyt5U2oxS0hCdzV6Mis1?=
 =?utf-8?B?dW12VTMvVjlONENpMFQwS2lkQTBUeFNCNk02bGxlRnplQ2FuSXVCRUlKb2V0?=
 =?utf-8?B?NDNEOWE5SVF0U0VXb2RkVXk0bE55bWpoSmxZQ2dsd0dVbWNxSGkzRFhGUXBn?=
 =?utf-8?B?MWV2bWtNellzS200TjZybzJvVmxUelkybHdUQmVvMEZ5TWFkeVpGYzVPN08x?=
 =?utf-8?B?WXljb2dmejJjdVBvejR0cEFEekt6cUhKdmJKeWNlbUVjWmJuaVlxSkJMRzZY?=
 =?utf-8?B?aFF0cnVpckptSnZWWG1RaFcwNkU5RVdZNDdLZjN6WDRtb0NDeW5pQzJCd3dZ?=
 =?utf-8?B?N3NrRUhIeERKZkNvR2NBNXVhVUVWYkMrU0xwWk1VMkJSK3F1anV2cWJjTmZM?=
 =?utf-8?B?VnBlQlMwQU1EN2taY3lSQXFSd0owdDh4YU9UbHNNbnRudUdtVTRrTDBuSXhB?=
 =?utf-8?B?eVRxeDhYNm1rcDhSTnBkZEFpcFN1VStWSE1HbjgwWEY2NzZ3bWpCd0cwZUhH?=
 =?utf-8?B?bzNtVE9PWGxSNVFuNTQ4U3B3Nkp6SW1jNHM4VFA3SGpOVWF0eG5NaEpTa29y?=
 =?utf-8?B?aHRHNjM0blA3N2F1YmxhWUcwZGVpbXN4ZDJuQmZCVEdpZ0hNTnYrR0VlTW03?=
 =?utf-8?B?RVVqUVlFdW9JK24yVmZCZmtHWVpNT0lXcHJHWEZ1SGRzY3JvTldCR2FySkll?=
 =?utf-8?B?RnE0K1Z1bEEwc2NMc2pNQndJbUJ3ajJwSlVmL1JncUNNejcyQUtTYVhzM0JB?=
 =?utf-8?B?eDdCeHZsNnJhRVdSamFhSXJCUjA0Y09YQ0RzK0p0K1BlZXgwME9tY3paNDVQ?=
 =?utf-8?B?eEIwc2FUWDlOVlFUQXpXOHFOWUZyaGlQRUhNTlJscytRbHh0WDU3bUt3MFNl?=
 =?utf-8?B?SW94emhrWTV6dnRPNmpSRXNMNUhUTVI0aFREOW1OS3dkUGJ6RUpud0I1ZWFF?=
 =?utf-8?Q?TBz1/J3g3kWcsnfnTcpODLeGbxRMgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnY0TlFTWFo0bFo2Z0pRMzZBRng0dmZlTmVPQ1hBcTJaS3RKZ1hhYlh6MVFW?=
 =?utf-8?B?emtXK2VEODlHaHNraVRsc3JUWVVCODZRT1dqckJvK3JVeTY1b3VnZXVVa3JH?=
 =?utf-8?B?ZFdwT0UyVkNZV2puam1OWDFlV2V5cTF2cVZhZC9UMmlPaW1XMWhReExzeVVS?=
 =?utf-8?B?dnJjTEx6MnkvUlhDVG51SUlXM2VmSVFhVk5rUXRFQTNrUEt2aHdoaEhsYVYv?=
 =?utf-8?B?WENPLysyNkVlTWxaM2lubEl6NTF3enJVeEs3SEcxZnF1WkNTQVhRL0pDcHdJ?=
 =?utf-8?B?V3JrcnZkYnVGckwzTjBCWXk4Snl2Sy9TQlp6d0lHV0J2VHV4V0tKanFBbURr?=
 =?utf-8?B?ZkQ1b0U2ZllHVG8wWlJ6UFZLU3dVejZWZXh4dGx1N1N1SnRkT1pmc3FUTWNk?=
 =?utf-8?B?cDdDZnJqYndRUUd1MFhqS0hjOUM3ckVJcHV1QUtjOTcwTytVSjIyUzNCeDZ4?=
 =?utf-8?B?YkkzM0dyMDJEM1RYdWRqVFNrd2NHdUFtTFFZSmpXeWt5b1VvWnM0ODBCT1Vw?=
 =?utf-8?B?SmU2SGh4MmVEU1pxVERPSXpGK3J5SU9FM0ZDQ1NkQVJCRzEvcWNZZ2Q3QnlI?=
 =?utf-8?B?NjAvbEdCZ21IT1NyTk5rUXRKUTlYVEl4L2N5QldMekpYYkhSTHBuSDlYdjJk?=
 =?utf-8?B?R1FYSkRCQ1ZqaWFWTzZacnlIVkF5c3IwUEI4L1VlaHhLeEErWERVaDNrZkQx?=
 =?utf-8?B?cXo5MUFWeFB4dmJKRG1BR200a1lHTnEzbFh4ZHNwczZTSEJwVEtyUk5rNDls?=
 =?utf-8?B?YkIvdkNlYmZSV0dieCtmTjNmU3lyNDFUNXBydFlNLzBPNHJmbnJQUWFrRFA0?=
 =?utf-8?B?bzBhQXFpVW9jK3hTbVR3bnRLRE40STJoVW9tQkpFVGt3MzZKd2RpUnF1am0y?=
 =?utf-8?B?MVUvdkRWNHdqcGc0eFhyNFl2U0ttMnlQZ2xYQ3ZBRzJoZDY4RUlVSUZERVh3?=
 =?utf-8?B?Q1lDK1o5aWNqdjNXRjZDazgrUjNMeEw0d2F6TUdJb2VwUVNyOWpXNGZnaUdY?=
 =?utf-8?B?Mzh0emJNUElEQTFWSUhWeUNYbS82V0JYV0VNOU5QN0JsMGVZME02My9ldVZW?=
 =?utf-8?B?cWlOUVhHWURINHBYVlVhYzFad2xuK1FnVlJzOTVPS05MTTVCWmRQYzlaTFFE?=
 =?utf-8?B?c1RkeSszcHdqTUhJaWFSR3hyNHNaY0lta1dmL3o4VFVWU2JXNHh4SHRPNkZp?=
 =?utf-8?B?M1lRZTRBUHdpdmh3d2R3QlNCU2p4Q0R4MDVkK1ZBaDVyRUVhRHgrZGZrd1VE?=
 =?utf-8?B?K2pMbVloQjgyVHgxTWdlb2FDSGE3N1NLbWh3dDl5OFM1VzFOdytWNVV1MTFn?=
 =?utf-8?B?eFNOVW5BQlpUZG1xZWhvVHY4YjdNUGJzTFJaNGRBa3h2WHdFMGprdVI5Rmt5?=
 =?utf-8?B?ZmpiWWJDK3hVbHZ5L2RSODFiME51RnRWRkkxSWdQOHVHSUNmUW0yWFpUdnlG?=
 =?utf-8?B?L1ZiM3A1SjNJOUpJM29PRDZwMDVlL3piQ1hCc3hnZi9qd0EvOHV3WEQ0bVNl?=
 =?utf-8?B?WWtZSHBnYWlxNCtSMUJtL0ZpbW9TdGV5R1ByL3B0N01vV3NyWDNyZDRlMDYx?=
 =?utf-8?B?cUw1Rk5qR24xa2Q3bU1mNjNVNFVBRE1NNVkrLzVBbit0dWRhY2VtajRoWlNx?=
 =?utf-8?B?eWVHTzhYWmZuTzRDaHRTOGtEbWtJYTdGUEFXVlNHSkROOWhzZDRYckthaUcv?=
 =?utf-8?B?d1NkakFtcnJsL2lMMFBLNHFKNUQ4L0hnUnlaZ3dwMXJud1hOVWVpY0FJTjRZ?=
 =?utf-8?B?ZUdRUW95ZGpiWFVKSDlGazFNcWpwWlBYQTlIa2JoV0FvS05qakJrUGF1ZmVR?=
 =?utf-8?B?UlREM2VLWWY5UTV0UWRlc1hlU0FROWxFUW9xYk90Y24yM3o0dWpTTmh3Zjdo?=
 =?utf-8?B?OUY3M3Jvck4wc1FpdGhnZVpwazBDSXg0eS9pbGc1MmpLNVhVTjJ0VDRXV1BJ?=
 =?utf-8?B?QlZrak5lV0xaVlFwTFQvWGdqRFBNTG1DOWdUQ3gxaDhrU2l6WUxWUXRFZFVw?=
 =?utf-8?B?cUViMmJNbnU0RWxLaUNiSGpyb0QyeXJ6LytVUldXdnpuTmQ1SUZLYzhBdmhx?=
 =?utf-8?B?aE83VzM5aEVyd2JubnVlem5EejFDZC9NV1diWko2REFwaUwzcHcrYVJlSjlU?=
 =?utf-8?Q?LNnwKbWw+TKhYY2SKMoUqcMKJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9072075e-a913-4518-0c75-08dde6cb0e57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:55.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy2hcSj4Xh1bcmYde61KdA+1kot+vWyyOCURCCcOISOzquDwwsEinA4GdxTsDiiNOYON78s7rEvmS2noRQ3Mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7752

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526c3a08c0bdc6134297fb010e6e926..4c52f22bbfac99722184b4d8679f48c4396b557f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1057", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vdd_12v: regulator-vdd-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_12V";
@@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can2_standby: regulator-can2-standby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_standby>;
+	phys = <&flexcan_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


