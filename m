Return-Path: <linux-can+bounces-4293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A208B30D4C
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA93A03443
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E128D8D0;
	Fri, 22 Aug 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cfzJhc05"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D027CB21;
	Fri, 22 Aug 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835573; cv=fail; b=ZiQav0LV2+A7w/xBpyrlVKEqcleEl7y+8LP9dgk+FjPL3a1AkU7LJl/qUff2IQEfKLsEe+i7XsBRH3sjbvRDmw0o1FrkNPNtqp3zQmFw6lW6MYwCohBtANwixAkrNK+tMJD/FXHRJ3D2I6zvP4R4o4OETei9c2hLkZDz6H3PQjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835573; c=relaxed/simple;
	bh=CVZIQ4AVFIw/s1OETU3s5dWu/tG87msffPU9zpJP2LM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cUb95z+Q28n8UCoJw6tktigPqHOBe0ydX2C8naSyjHbaFwK2ykwotW2N1lhm2sPz0BAoCtcXmfuS2w/49pgXkAKR+Ou7WZxtFdpnXwAm1UXvWfVrM8Db5eBEw7BOeX5yXv7Zaan/3oy4k67IEzfxets4QJc/RRWRkf4JA4rli20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cfzJhc05; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIBaYDUzqtIxhhcuG0+QFrx3UwRwbV1UwF0nrqOacfEWxoT6FOeZsJ7gh4Svdu0wfJGhMcs7SVlbFMas8EVru4tZ5O9NO5HiaXqzQK0ypzRRw0+s1SMG+401AIdQozNVybJMgGqQPdMCIxgIiAzMveNjEC1ndlE2qd+IOE8LmE0evMTduy5PW3PVBft97WRLpkrP7HW7sc6vJdejUZSeEe6YPW0V9Z0m0Bq1QgzcskYfXISZyDk1tF8dFnylCC09IJrBrEKR+2Chv5EtVFZZSmJWzHPtivvdWZTBOx66yoK982QOFm6EGcWSpnpNXKpsOGZME8LursxC48UKWBuUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyDtflgezckMwAVfnJ83Q9q7tEaJNr3QDTrqbUsNXP0=;
 b=jtTIcdaffPz85ARi0rWlA5HRcMf0sDfW6/OBJdKIyP62AZuopGgCif/Kbr7xPsiWfh9GyxTd/dMdSxSMoV2ZD0U0tetErReGhX+790kl77K0LPM6LNMegIRMKUdZ8v9fSJLlRkfNMjzLNctbRiwV3SSjRnHIjnNGDie8q7LCraUYlX6LquWz0lNVaIs7Sbsh4Eab1BhPiYlJ6ZsJPjmMviF1EmeKwjvlAJu1xXiMXJS7m2zFH5fT6EZ1689Jx1467bfKEEgfGQGAOfZsad7UhBvRLqR0OlySreasGA9lydevhCEOqlb7Gl9kUBlkbakx1RHITcKuSs6ukD4XoHoWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyDtflgezckMwAVfnJ83Q9q7tEaJNr3QDTrqbUsNXP0=;
 b=cfzJhc05AEzveGDrXtIN1ehQ7aNm2OFx/VX9n9zNTU95pSDuqc0lqOjIq69ykjWEsyoUhaEJJJe4ouIGiNOkonrJK3wVWzlg3PvfBWKxIlSHp7xH7Beq+EZQlz0yaHjyOFTCJCOA3atdG2t+QfLd1smwVtFLk0EA4gCWshcW0Oja0ofLHeH8IQOq6kqDVgAhfpP3skBif7irZDCTFjAcn4NIykBqiUxK8KkDZMov4gIFwkhgs4k6lpctrtTuxHni4GDazSAPgqFJ9vfKOpKqUJCJ2ZzsZXWWhDPab2F/p9RDNkJEdYCZt3JCShKe+8Eh4vcbg5UkGZDKzzdQGodMiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:06:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:06:07 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:30 +0800
Subject: [PATCH 3/6] phy: phy-can-transceiver: Add dual channel support for
 TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-3-c075f702adea@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=7283;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CVZIQ4AVFIw/s1OETU3s5dWu/tG87msffPU9zpJP2LM=;
 b=vCxqVceK3vZoMvcRCHaL3AlTMiF/+5SByFdZnianN7Wx1NBzFKzB1zI9TpaLasNMAcdO2oLFk
 kRvJOwt1SOgDfOm79A8icPYV8NgbJVOM1NMdpCMFBV+f5EhTNIMbeuY
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
X-MS-Office365-Filtering-Correlation-Id: 2d6f6ad9-d4fc-4bfb-7bc2-08dde131382e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGYvaWhMZ1VIeUgzVGppbHIxWkozRTVyMmlaZC9pRUc0RTFLa2xleTBRc1RC?=
 =?utf-8?B?ZWRpTDhHR1d0cTI2Z09QMkJnbDAzU1pldkxIVzdFQklKMm10VWx3enhpaXBJ?=
 =?utf-8?B?eHdSOEtNNG9nNUN1cWpiM1RheHpyeVlmS0ZOUlljZk1ZVXowemRQbkRxZ0ZF?=
 =?utf-8?B?SVhreXBEbWJ0NnZJTnBNZ2lCSW8wUlA4V2dwbThvdzNwdVBHdXNoWU12YmRm?=
 =?utf-8?B?T1R0OEMrVEhLMXhIOHNLdFd1bjNZM0tKd0lVd0QyOHptZ3JyYUpOOUJQK0ds?=
 =?utf-8?B?TW9jMG0wQ2d0S09uTEJZTncza1RyNVVYWFUvdUc2ZG5EM3gvSzhRUFBxenhO?=
 =?utf-8?B?YWxLOENJN3d0YnlieDJpRzJpdnF1UFJJaUtxakhNeC9HSXlabUVnaXVmdk5z?=
 =?utf-8?B?ODZvTGNVNThFSlBZREJ4ZTZ5elhSY2R4UFp6WlYzejZ0c0pobDd1VmhqOG1y?=
 =?utf-8?B?MDQ4TkZDb3hvS3ljWFYxbThYcHV5WlQ0MmlvTHRzamh0Y3NGRGhET051Q1lB?=
 =?utf-8?B?UUtsUjFBNzAzSXowaDVaN29yc3dnTXJNUEFpUjJnNURYWllVb3BKMGpPV2Uv?=
 =?utf-8?B?by9iN2p6ekhXVWMvNDliRzgyaklaR3pYSE5oZkJ5WUtseHBhSzZZVVdVU2Va?=
 =?utf-8?B?U0hSQ3pibENpaTVSRFZIUFFRMEhKdW1FRWV0MlhCSHlDNENnZjFLMWVqbncr?=
 =?utf-8?B?UDZkNjlTMEUvcTVlbHFZbzBBSHgzZlpOcUxkNysreEdRYVhocjBhWjN1YldY?=
 =?utf-8?B?Y2pWZ0pCS2hva2ZBR3p3OHRkcEx4S1pZZ2UzUUMra3NJbzkyRU1IVVN6eFpo?=
 =?utf-8?B?d3lkOTg2TktNVnloK0FKZ2dOeDdyTXJFUEJSTXlSOHpnd2pmMDVhMjIrY0Jv?=
 =?utf-8?B?MitLdDQ0bWNZTUhucXpZSUdlakR1R3J2TW9DQjV1ZUo4Q0RvRU1ibnFCOUZw?=
 =?utf-8?B?T2VaVGY5emxuenZGdVNvcGIrc1JKZlZJOWNkSG13SGhlUHkrRGNSK3hPWVhG?=
 =?utf-8?B?STVNbVRrc3V5NHdiNXJ0cmhKQlpsbHI0RTEyT2h1N1hSVXNHUENNelhpSWZ1?=
 =?utf-8?B?b3ZmVWJvWDdvTHZ2ZEVIQ2phOGlzN1dwNXNuWmFMYUNvdU1PeCtweE9nbWM5?=
 =?utf-8?B?Tk9KS1lyVWEyM1d4VjV6RVVKTUN3UUpQOVNMaUpHUkRiMk9oZ2oxZ2g5aVFQ?=
 =?utf-8?B?cG44UHVMa3IxZzUyMG45NjZEZGs3a2tmQk5pQXMxOURndHBjQ2FZS2lBRSta?=
 =?utf-8?B?bWtHTmJUcy9iTlAvZmR3RWZOQXRMYmFIUjNERXlncUg2S0YyQ2ZDRlc5cVFh?=
 =?utf-8?B?cm1QanlvNm5qVVhoMU1kVnp4YW0zY0pxaVFoWkVUNkZlNnI4UERrd29lVTZs?=
 =?utf-8?B?eFpka29LeVRmV2JmUzByWlZCV3NDVGJJcm52WDhVNUNKcnRvWGI3ZkxwM0hn?=
 =?utf-8?B?Z01TUmFPOTNLdHlxUUhBYXBsSjN1blVtUkVqU3hUZ2hudEJTVXdvcWdzR1lF?=
 =?utf-8?B?QmZVWi9xa1dvdk1ZR2RTRERTQTZINzJiMXRhVmh4cHQwbHMrWmhCSU1wUEcw?=
 =?utf-8?B?Nm5tczBHNWJ2Q0IxSGlFSkhNWG1WaitveXBGSWdEcWMzRHE2dDdNQ2g4YVFF?=
 =?utf-8?B?M3Bmc1lueW5VZlBKQ1J4QlJCYkkxNjlnb1JQWCtsT245MXVLNjBwU0UwT1kw?=
 =?utf-8?B?d29TbEw5RHphNlJJbjg1d013dUVmVjE1TWtKTVdjeWlNc0Q0ZnB1L3pGV01T?=
 =?utf-8?B?OWRjTTRGSzd4VTNSNkw0aVlPRWVzRERNVTVVVE5EbGkzMHl0Q3FBQjFRN0dJ?=
 =?utf-8?B?Rk5oSG9vNERJS1MwNVNscVBGa0tWMWgzM2VlR2dWZkxTcW0yMXV2NW84N1pJ?=
 =?utf-8?B?VWxqcFpUQWM3RFdndy9aQVZJdG9WRkVHWmNRTzBDcTdNeEdLeEdmVVh2Mkdi?=
 =?utf-8?B?TjNsWFcwNlBYSVVsRWpGVFhlellDVnYzUWRQM0lhYTR3SHdZWTROaVBOQUxZ?=
 =?utf-8?Q?5OBQIxlUPDylJVdSFi8mXDbhsAxlk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFV1VytJeGJmdTVrdlVvY0hPODVEYlFPZ1VDZ1o1UUtQb2U1UGxmdjB0RzZP?=
 =?utf-8?B?SERpRDluYytqYzdZM3UvMDZkdHhTZFhFOUdwUXpSOUF4bmhyY1ZLaHVDcFM5?=
 =?utf-8?B?YTdLZUFOQ01Hc3p3Wk5RUEcwMjFjbC90NyswUjQvYUVIT01Pb0dsWS9DTHNr?=
 =?utf-8?B?QmdJUmhIV0tSWTdDSW8yY3UwMkVkY0JmYlUzNHdJczJ4a0NMWENRNmVMT2Iv?=
 =?utf-8?B?dUp1R095c1pLRDlzRHVHSWQreVZZS3IxTmdWL0d5S2xoQU5FRkNhOVJMQjZF?=
 =?utf-8?B?N2UzUnF5dkFPQjNTK1Nkc29qU1RQWS93VzFNTm82c2ZoVEZNdnZmWlNDaTJl?=
 =?utf-8?B?WHlCTzJPcXJBUFNlaWs5dVdvYlpNNFp2M2lnSFF3WG9ETi9GUm9HT1gyaW1Z?=
 =?utf-8?B?WUNwbExZZWJhNXJzSTFONngzRjNhUDhtWUVVZTY3ZVp0dEU4YlVBWks4TzNv?=
 =?utf-8?B?WUp0OFJvdmg1U0hnSnlScmRLNHgvMUd2eVR5ZUpIa0NVeStQRU1nc1hobU1x?=
 =?utf-8?B?eElDZVI5L3F3SFFNamZ2NGIyVVNwaDZHSzlMRTI1bTBIc3ZqWEFSbUdMdTNS?=
 =?utf-8?B?Z3ZhOEo4YXhIMzdaVEJKeFZoSldGOWpGektKaGUrZUdZeDVLQzBiUlpGMS9v?=
 =?utf-8?B?QnZMK0NORFV4NVdWUnY2NVhLa2JwSERNajFlNXZXSUF2SUhLZWI1MGJWUEx0?=
 =?utf-8?B?M3NUMERaWXFPTGdHMkg5bEJhZjdncHBOazdCUU4zU1REbThIVUlCd2VZcXlh?=
 =?utf-8?B?TzB0QytPQWs0dzNuN2QwaGJkSFVrVzkyaFBCV0JYcGk4YTlXOG5IOFlWT0Zh?=
 =?utf-8?B?eVJjV1MrdlBGYlVISWxEeXVSZFQ4d1ZJdTQvNFJ6VXFzcHNZTXNmdFZBelRy?=
 =?utf-8?B?bmhKbzVYb3F3UzZCTko5SnV6QjZBQ3pmVGFoeUVIS01hWnlscVJjZVlYMVpG?=
 =?utf-8?B?OVkzMmd4TmJub1hxUmVuNTloNjRhb3ovWitqTWhzVy9BTUN2c01za1MzTG8w?=
 =?utf-8?B?cFhRTVZORnRtZTlmcHNpdkhYQ1BobFRmQ1BqQ1ZvenI2cTJEamlBK2RZNUlm?=
 =?utf-8?B?aCtxTTBmWXhucDVFVUttYW5LR2lGcjRNcDR0bGw5V3ZlTVM0ekQzUXh2VXpv?=
 =?utf-8?B?MzFMbHZnNi9Yem10NEN5d2t1bXlxbmVzN1dKSEVzQnVDRGdoK0VhVmNlcnd3?=
 =?utf-8?B?Wkp4RHpNa0srYmwvMU9tTVBkdzF3MlI3MnVrYWdWQWJjQnRsVU42RGpURUlZ?=
 =?utf-8?B?YVlvb2NTVVVMYldWOTl0aStkV1U1cWxGcEhTeXBJdmJLU0V6Q1hOQ1crSXht?=
 =?utf-8?B?TldtSGlvN3BxdTFQTWtvQmVXem5kQmtDWm1hTE5hRkt1elc2N3NRaE9SVUlY?=
 =?utf-8?B?djF5WThDNTR3cjJ1VitpcVdRa0lZL1J0RitnRFpsZnBtenpqcGE4Q2VnNlAy?=
 =?utf-8?B?OGk0VDl5dUllU2RhSEd1ZHVaU0NGektLSDBYdXc2ZEJBaEVmYm1RVVZQLzBB?=
 =?utf-8?B?b0VGaWNXeWpxQVBYbldROGczR1haMk54aUJjMGI5eXAweW5OeEd2dnVyWHZZ?=
 =?utf-8?B?bjlpVW8xYXNITnRtMjdtRnhoSzRhNzRmVXh6aFZHSWFYcGQwa0VDWnBleWVj?=
 =?utf-8?B?SU9nOCsyQ1NyMjc5ME5mb0d5aGNUWTVNMUt0YTdmTnNLY3hlMzNrblJld2NK?=
 =?utf-8?B?ZjdQWCtoYmo2d1VrMmw2aTBHdjZ5SlBXSDl2ZEFscW5YZGlCL1hPek1XV3cx?=
 =?utf-8?B?MkJJL2FLYk9ZYm1NeHIrQXl2N1lWTEY1MWZUNXdVNVdqakFVMDM5TU5Kc0Zp?=
 =?utf-8?B?LzlnNnJ1SzNicGxkYVpsbFBVLzhvVUtzcC9tYzJaTXZUL01jOVQyaWN3MU9S?=
 =?utf-8?B?eGU4L0V0MnhTQnZmTlRERjdNUFRUVEpDaWNsNnk0dlMySG9JbmlNcmFIVFBM?=
 =?utf-8?B?K09kd3NhcHdtL0JUSVM3eTZDZTV0Z3ZHaGpaU09EOHRTVm13UHNjOFF4TDl3?=
 =?utf-8?B?LzI0YzNjMTJaeGx5YWZnWFVMTnRzbzloaEVuV01uSmM3R24wYkJ2U05yU2oz?=
 =?utf-8?B?ZkpkYWVuWG1NcXA4Ky9raytkZ1ZRZjBHMldSZXZTTG9idDBZTnlScERuL29R?=
 =?utf-8?Q?aNTWdsiEoJJ9mX8bwnH4u+ZiS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6f6ad9-d4fc-4bfb-7bc2-08dde131382e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:06:07.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUAJjZP6/SNSD1rgAhKGIn6UhV0OxwXogWjkfnwxRHB3OXI3nrL5Dzg5QwQSISsCRomIk2oKw7FFY8dq9tUCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
  has two channels.
- Introduce can_transceiver_priv as a higher level encapsulation for
  phy, mux_state, num_ch.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with
  Sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 117 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index b49371a1272cd8a25b5e2271586b756103c64f0a..0e7b23073bfa8eae7200d30dc657a979f6cc9d86 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,13 +17,20 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -32,8 +39,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +63,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -76,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -85,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tja1051",
 		.data = &tcan1043_drvdata
@@ -107,11 +122,27 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -119,52 +150,70 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
-
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
-
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
+	priv->mux_state = mux_state;
 
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
+
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


