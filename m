Return-Path: <linux-can+bounces-4403-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC8B3D723
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E423B0546
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852121B9DE;
	Mon,  1 Sep 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDvEux8B"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9A220685;
	Mon,  1 Sep 2025 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696733; cv=fail; b=XXmJK3p10wnD4UVDCL95r/uB8scxiK59xXdCWqmDEMlznRWLnjL6pN3D2PBZF4BxfbahpDdgrlkp+GEthVcSlqcoBxN//tEV7eHmJI3lboYeS7p51OsDwZeHIs4dZZotqsqjquUddtduep/6XKzlmYD/f6pu1gZ9QzR8AdwEd0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696733; c=relaxed/simple;
	bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r9kSGHeCh8mezof46Mp2bVcKehihr/Q9TOYNiZySpsRfm1Id61R0a8PtWIabqFGJNyH1uDcQ9Fy9y8qavU9E2Dy+6WZX14RQnTn7exluCPkJwmio1OpaJHdKQ/XyNnFGHcpoi5KpXfIAbEtlO4YOfh3dHTFxO+5KDxECAjdUbSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDvEux8B; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcS50IEzMmy95bMDgEZ8OtrFue3GsSZdUTCNe9pHkoics8sgBiiE+xY3rbjRWPrHCU1/JVFvU6lH8IYiVJgRmfiDOkeaaUuiouC6OI1uLNPqxWph4pWEaXSo146NJyGNf+4BKf5w3Vbs0yiJrhfBE6Fd3zhtBYLg9ZNl8qwNGjV8MNg7MT+V9RZYsFvWck6tkQXLpyICG5nScH0km7Va6B2QJ75XNSzljh6hjW+jdZzKh89NeDTXj5zbGY8S/9VG+MCoVRIttLXPTa4GW+sgpoUMjZqLg67NBz76nSh0tqiNrLg0NFOHm+P0+cIW0cTtD1UTDSpqbDGlBTe79fV1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=CasJFp2WnX84cVWRwiy70fco4N3RuAqMUt0O5H3+7ARMTMXZmRi8okWokwY6l10sDN6tooFWJmTw8TatB7ARh7FkNSAgLqryJTrFIGAszgDoSigZOBfcoJpMpju0JBI1Md/X9qIM/SIK6b0KKk/L8AXNNW7992qyG+0/cGy+e4n5kamZ5VRGPHijQibxKlErp0kWzu7Kcv6QcS4kzrqyKlOUOl3fdFkcAJZneCjnS3XCU2QmA9xUbJv7gtGpQHKV8SyxOMoUz2JUjF8LyPtT4ls5zBn8lBplQCzg6jOD9Wp7JX+3HFFxJ+cdugNsuLAqq1yaHC/4YzNjq1uYo/t8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=WDvEux8BY9scyXZoNE2FLvxXu4Z6rXVgA33QtUtyfQ2MYVplpA665GIniJJ4zY2Pc8t4XWSoxaMXxb9BFD20Gty+TFIj0xH2frpgFCpvR7di5A35qTNaqgz9kX1YUQhkJu2pAig543qZ5XroLIqBHZgilYCDaoxka5wu7CRBR1D6X9oLhCKsJZSeyT48gSrNKoAmckSlHOH9iB4NyUAM0zSME2UZytH1YPM4XleptHleQBdXHWHlVYW9igB+bK346BZxYJlFLBBugI/veCoFUxBg1qrboWvx78qxYbKZsmQYLgc2ytC8BMTiw5hniDC8bkQ4ROeLSQz0UKvHxdrQGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:18:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:18:48 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:12 +0800
Subject: [PATCH v4 2/6] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-2-e42b5fe2cf9e@nxp.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
In-Reply-To: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696708; l=4492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
 b=q+bEfkhjZ8u4NsvGSyuTYJt2IdN/WRfTK5hqE7St8cgqvVEGHcAu3UpIy2DfXYYhOEE+W77C9
 paMq35lHdfLBD9i+ySBKsCKcMIw6wDkf6WyPmGl4kvTlpaVJ9oN2xYG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bce89a0-07f5-4afc-3574-08dde90643f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEZBRlZ0VElLTlJ6UTJNTGpYZTQzd1U1VzRlYjJ5dUlxZVJOQ0lWMy85S0Zr?=
 =?utf-8?B?V1dFWDFOV2VLWWFORGJMZExQWUxLa0xHRFN5YnJBVEk0NHZpL3c1dWVaT2kv?=
 =?utf-8?B?TkNVWUJlT3UvV0l4Wmw1UFhVQXNKc09mRUtkOWJjRjZSdHJ1OG1Id0NsTi9r?=
 =?utf-8?B?d3dQTmhQd3NuN1VKY3crcVBTaFdoYlNhdkN2dUxVUWFFM0lIeUhhZTJ3TVcx?=
 =?utf-8?B?VTdIcWExZEw0NmdKSUswZlQ2SGJUN2MxMlBJSi9nWW1ZNTRMSUkzcm1QWnlT?=
 =?utf-8?B?WEVpc0RNd1lGRUV6cWVQY1Q4V2d3UVFzNjhxemppRk9BM3FhSzV6QStEd2ky?=
 =?utf-8?B?OFU2ajErRDlKeDVxYVAxU2JXZ0ZYY29rNFJDeWhKY2RXcWpid0ZtdzdNT2Rn?=
 =?utf-8?B?TTlVWTZVZVFST0h1VFNkUWNWdTJYNnIzZ0lZUkxXSHAwZ1BWVXRCejE0U004?=
 =?utf-8?B?K2tKOTZNRExOS3NxQVdTQW1JKy9tQmNabWFSMEhSVWZBOTF0UWpSaHlDMlRr?=
 =?utf-8?B?TUxxZHVZb1Mrc3pYSGowRGRSNVVwWTIwT3VFVWFEZ3NoUnlXNndWZFJFVm5v?=
 =?utf-8?B?WDc0RzNtUUtTeTJKUUNZM21LcllJMnRMaEZQVEJLSEc2enhjWkpGcnR0UnJw?=
 =?utf-8?B?c05nVW11dm1JM0FLRHk1SEMyQlBPWHYrZmRvT2dWSXZvTW5hbUFXTzRUdWRH?=
 =?utf-8?B?dDQ3c1MxYmMyV01vYmlIY2N5MXdQZFNQRExIR0NtY1BVZjhaUTY1QzhyOFF3?=
 =?utf-8?B?aysxdlFJVUdHZVBHUDVmd0wzaTZjRDZ0bWRsa2dLcUQ2MWJXUTY3L1djbHJm?=
 =?utf-8?B?OTQ4R0owM1VlUHE0TVZUdXZEalorbG5nMS8yRUcrR2QrdDFjMjNUak4zTmtT?=
 =?utf-8?B?QmhtSzhpTC8ydXdkbE4vT2oxajRPWGd1YzV3Q3FEOHk0MkIwQUkrZ2ZEMEg3?=
 =?utf-8?B?bTJBUXJZVXBOR0V0d2NRMmVQY29zTUlXNndPTlJhLzc2Y0NBNnlXVk1QcWtz?=
 =?utf-8?B?UnN3NW1nQmRZcFpIbjlFUER1VS9rVnEycHhvYkF1cjZZVUl2R1l0QjRSSmdI?=
 =?utf-8?B?T0ZFQm1qamlVZnJsQU80OWxhdFFFTkdybkY2NlBtSkh5MFZ1dXhwN1hidUdt?=
 =?utf-8?B?YUxJNTBIY0NlNGVlYkg5d044UGM5L2YrczR5bWlVbXNJejRoVGZocUgzdWJK?=
 =?utf-8?B?aURVQkVwVnJlcFgwN0t6VjdFeS9mZkxsa1FlWm00dDZZMTFQa1NuVUZRWnU3?=
 =?utf-8?B?czNPcFZZVWpzVXR2K2JkSVZRNFdzNWRSOW1hcEFuNEZHWXUwZ3d5MUU5QnZT?=
 =?utf-8?B?ZmlZUWdrNE45UGVSOFdwYW5aWC9ybkJ5VDZTeUo3Q21FcXlsVHd1U1BtWmx5?=
 =?utf-8?B?dmFyd25ZZEtxZU9uM1JaakZRWDRFRjAza1FnK3ducE81c3prQ3g4TWlIYUdi?=
 =?utf-8?B?ekF5UGdVd1pESC9kM0wxSFFlSWlpYWNzdENheTQ5RHp2b0llbGVtekp3NG9O?=
 =?utf-8?B?ZWZ4MDd0TTJtZ1dJWXcyQ2E5b0JHUmt1ZlNnTUJJS1VIZlBoMENMNENhOXRB?=
 =?utf-8?B?T3FSWUZXN0ViT3hSVFBCODJCRWZicUxDSVhzWjdEdGNickdtM3lTS1FhejVm?=
 =?utf-8?B?Y0t1VG16aTg0V1NnK0dDa0w5R3RBcE9XWElBQTVVSDdGSElSVlorZDF4bm1z?=
 =?utf-8?B?MGxMclNoeVJSbGxqd2I2YjdjSmxaY21HcnNVbEpQSUM4cjNCTlA3RjhJcW82?=
 =?utf-8?B?SHRLdTRYeUNRRytOMnhtbWVyQ1lkVTBNcFdJZWdJYS9vZ1p0Ni9keVFnNUQ4?=
 =?utf-8?B?TXpmeDlDcUR2VEdCVDZ3dVBacmxOK3g0Z1FGTnFqZHkvcjhaRStYOWhvTVJL?=
 =?utf-8?B?SHl0UUFVTFQraUR2RWlhbVhEdmdWNkV1MGYzVzhZdkpZZFFBYm5jUTRsNlZk?=
 =?utf-8?B?a0JjQ0RlQlBCRnFTakVMeWZYallraGNab0ZJYW9kNlNESm00YW5yb25jd2tp?=
 =?utf-8?Q?89cgeoYsoeV8PLBQaUkg82Lg3B8884=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGoxT0V6QmZUN0N4WlFmMEVYeTh5RUpnZFBYOW1GbzFqVTBUZFFiTnMwMHp1?=
 =?utf-8?B?aDZTNjJHSzh6QVN3OGtob3Q3TlpKRVVYV3oxZWg5bENCZSt3SFFkTkU0Nk0v?=
 =?utf-8?B?cXA5UDltOU1oUzluOVNkRi9CWVRORFcyenBGWUs5N1BiVklsTGR5QXA2djVj?=
 =?utf-8?B?ckdqVW9aQWVsTytLajgvRHpaU2tQWVh2SU44bDk1bms2TURMditpMGp2bnVC?=
 =?utf-8?B?YlF4Q0pGYkRyTFM5QlNIVFc1QTFPb0hoT1lzTlFjQUNTK0JZaGxWZWVmd2Vr?=
 =?utf-8?B?REc2UTV4S0pIZ0dKNVZlMG5KTk1JMW1KaG02a1V1OG1uVERhbmZFQU1YUXY4?=
 =?utf-8?B?NXArOFRGajI0elNlN3hkOGw2Q2MwdVJjK1Zab0FLckhmRFZEaXp2MzVKZzhw?=
 =?utf-8?B?Vm44OGVxUkk1YXh1ZGxianBUcE1zUzhjUEF6cEFoOGRnU2MvZWRFUkNTU1d2?=
 =?utf-8?B?MDVqc0w3dmNSYS8ybUpaZTNlYTE3NnZWU3QvWDhwTnFyQlJPaTk2Vm5JaEh6?=
 =?utf-8?B?aG5VR2VDeXVlS3NENWhZQ2MxUkdGM3ZDVm9sQ050MlBMSzJlY0Q5ckZnREoy?=
 =?utf-8?B?VnNEekJ4T2ovMmJhOHljZ0tqOFR4OHl4cDM5NTZJRHdnSERJdjNRek12d1pT?=
 =?utf-8?B?WmhOT3pOdjdLckNpN3FaeTZwN00vYjJ5Zkxvb0dSQzFlRmlEbk9SNFkxaWky?=
 =?utf-8?B?SnQwaW5RdjVKcERuc0VCYjdUUWYzZXNLVitIdHdNaHdWSEx2RGozQ1FZOWFl?=
 =?utf-8?B?amdEVE1iemZvaGprQW9jTXFHSk12bXdhdC9ucittMTBsN09pYmEwWEJ2czhG?=
 =?utf-8?B?Y3JwZ005RUpHMHFKOERYM2t0dUs3eFFYMUk3dytZaFJMV3VCc01mZFBsWVFo?=
 =?utf-8?B?QnVZOVJscVdpakFhVTV2eW9sZEhiaDZ2R3RBcWZaNGZzWmZQMjUxSW41cjJt?=
 =?utf-8?B?Zzk4R29OWDk1dkRUM2xnTlBVZ3k3SldROEduUmdsU0VaRGh6Lzh0Q1Fhck5r?=
 =?utf-8?B?cHVMZXI5ejhQZ0MrdzRVNnkvWVcvZXRlZ25XejJyY1RFUi9TZWEyMWRjSFpu?=
 =?utf-8?B?VFBqTFBMUTRVTU41V2EwRnFqamxNZktiN1lCSmpHRHVXOUt4NGhtcXVkUlZZ?=
 =?utf-8?B?Q1NBNmllTDFCUTMwcVI5eG1jRnMrd280cUgzU2tZM3UydndVQktuRTFTNWRN?=
 =?utf-8?B?azNpRHpTUy82NjdVemhydWRaVlkxZjBCM2xiNUUyZVd2VURJSWNPQWdCZUo3?=
 =?utf-8?B?QStBYUNwWGFzNFZmNEZxTTJOeHEzUGlhcXk2VGNnK3VpbTYzMWFsTlo0Rlhi?=
 =?utf-8?B?d3REOGw2SkxmZTFOTDVrelgwRjdhcG9zOVhDakFPWWpPdFRiZS9iVW9OWWV2?=
 =?utf-8?B?SDB4akdqM0hDcGRTb2hCRTEwYmtYYTNFb2lvVXJGMm5CMmlhcFd5REJycy9w?=
 =?utf-8?B?QnFUY2FERUNDTVBGLzgvN0laZFl5WlFJS0RhVVRBb0NlV1Zhd3RQYTNSRVRr?=
 =?utf-8?B?NW5SQ1hSZDlxaGN2ZTNIZEY0cTRPTGtyTU8wQ3BVYXdpTngwWmNoZkVhME9R?=
 =?utf-8?B?Wkt5ZGVKOVlDd0FPdzlVQkkySHZpSFRHWkJjL0d1RG9zZldCSmZtM2NDSkRl?=
 =?utf-8?B?RzhHbVJraHlqRHN6bEErT2toMlYrWTRLTzJpbFYwYzRYV3hnL2gxL3JpQlJn?=
 =?utf-8?B?MG9MNEIwdWpnc2g1aXU5M0RuZ2lQWmJVV2VSckY4UHpwQ3RkbjdSMlI5RzhZ?=
 =?utf-8?B?MUxvelFMbXpWRmhJVUJZbWdpY3Y0RDBGem5RR0ZNODZMVHlxcWFoL0NGeWhJ?=
 =?utf-8?B?TW1Ob0xHLzhMTXJmZWlOQUFUMGd1czgvVTVzSjJ3M2dZZXd5b2tabVpEQVVQ?=
 =?utf-8?B?Nlg4bEt3dElMbXJnclRuSmovRGhMazlUMCsxSnRxUTJQV0taaHJvS0l6VUZP?=
 =?utf-8?B?bjIrUFNDZFV5bjRDeDk3d2JjR1U2U3p1NU1mZjlVQXBUOEVZcFRZU1EzeG5J?=
 =?utf-8?B?VE9ndzNSMW5zTEFYb05pQzlFcUcrUEZTeXRpRWpJME5XNDVhNXRqaHlJdzRV?=
 =?utf-8?B?c1NBVnFrN1g1MS8rTHdMTmFzaHMwVmdZalg2eTg5aC9zQjd0bmRFcGpzcVJz?=
 =?utf-8?Q?H0tHhIfGFlwVF0XNS0dFp6kuv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce89a0-07f5-4afc-3574-08dde90643f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:18:47.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG6hzrXx4tRRRpFRwJa/6qv51cuB26AdZrpNmfUrdXke7Ki7xoLkanReSQo6G/kkrlv5ocscPnp6gEzdnvpUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

To prepare for dual-channel phy support, introduce can_transceiver_priv as
a higher level encapsulation for phy and mux_state.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958a17ee749a3f28e9 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -23,6 +23,11 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
 };
 
@@ -32,8 +37,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +61,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -107,7 +112,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -117,18 +122,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err;
 
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
-
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
+	priv->mux_state = mux_state;
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
@@ -142,23 +154,24 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->priv = priv;
 
 	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
 		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
 		if (IS_ERR(standby_gpio))
 			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
+		priv->can_transceiver_phy->standby_gpio = standby_gpio;
 	}
 
 	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
 		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 		if (IS_ERR(enable_gpio))
 			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
+		priv->can_transceiver_phy->enable_gpio = enable_gpio;
 	}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 

-- 
2.37.1


