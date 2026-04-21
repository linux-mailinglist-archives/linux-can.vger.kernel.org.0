Return-Path: <linux-can+bounces-7382-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNRtNPNQ52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7382-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:26:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A394397B9
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B7D301C8CC
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC943B0AD6;
	Tue, 21 Apr 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eY9yDmFR"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F633B4EB7;
	Tue, 21 Apr 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767177; cv=fail; b=j8qa44dNl78vqd7pAXbbhN6s0mAAxafR0wRLgUyjzopMnoMISo82UGhGnAtjBXBA4Ul8ZGBPNin9NGjvE+1y63gQpTh9o+ivmqRz2yFJNJ1yMT/xU35PprjUlzPZtioNfHqbYfzFhbia6d5hDTmXlpvNlXrOJicAV88rjZ6DnEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767177; c=relaxed/simple;
	bh=VlaV463z9LAC1wNALjkbRCbO3hKIHhq6Xil8Uqyaj98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjdORMO0zlXGpvEJCKFdR0E1sm8c2I6ZxbZPhc/BtDawCrsPuWdNkCxYxKUz8FKhmmJMZKLOT+mr3WJu/9HIOsitL2/QSCH6dCXAvwTO/XR0ig6kT9VZbfPEAH2FUyFfcRsOZ7dgCFtpqWGHi76Fnz+LvVtFyVzk3T9w46Mg8HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eY9yDmFR; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLty4DVj4xZ1NUBmTNUL+Yq2BiWIpnyE03k2KY4qlHsVUzkFgQdFme0p6Q99mrW3lj2FKHoVBHRwE3EYED4gs2exNvmTQJN6uCV/7C12ZpbSSTDCs0rJXMLxffOs72LhBJfLCRFZ/a9YzwQ2hC9Rartgtaj/zUs2WSjxJetcCWrwCuxLsb134JFoqMhThZJ+pUBZAzOJMGAesXAzTeHh4MMkXMTZmPIFW6dYGzsc8RJb2DXjojHeS1LGmO9ILQlQioGLDFKU+ysJj4cOhHahxiwTkTlHX3GK3DB+nqu3YQt7QIfOK4eNXwtWtVs0Fz41KhbC1EnMTJEpaXN9Tf90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=WTpu3/dBkHuPCy/wYZRCHlpx3Djp25s/LyrU+eTGTiwuEAFq6SyZox4orqMzW1lPx3AGsCmKI/xAj0fwLB7vnZBJJe7s7BQEYgJhU0Q6xkH1GPYk0JX3wA+f5mBUAxOX8E8RL/j3F4JhNMbKLx3+6k182EZ0ozrfo85U1e2/hyClLtXUMFSFF3xUMHBvlznDaFnW7MrbbwtbOm19lmaZALP3A4AnSS+jCXoKTaOarKObXdmRkwjnrery0jiZ86jA6XRs+kH973sZgXmxmzlyi1V7NU+JjQqaK0nPYP+wktAbbJLjgWJ68UrJKlzBQhF76Ux+ASu16iArdt9O2wDLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=eY9yDmFROoD6E7hZMxyIDjXJTyFmbb7UDSWh4Sww8ZCq0Jl/E8SvEUuUm4WXfgZ+1ApPtYe0otikGdVklJQC3aoTND3Fe4c6OJZ3pwbuJW2fzEB6U6xwF7okKPFMt5VDuX/U/1o4nvPVaF3VjE5pju5LjUw4e91pq2gM83MjWnf6j88YxuGSFNOE55CWyi8ijRXOCyQRz4+mAmSlTbXImmA72SvyOtdldHcLNCOgVzN1trokUC8B71wiYp+2ErBeooOFfoKwjBnFQ2yEGUZ8VM/lVRbnVYMOstAGqzMOVOI9lpZouilUe7Em0kR0aUwYl1rX2tQpwZmQruhvCAMrTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:07 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH RESEND v4 1/8] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Tue, 21 Apr 2026 12:25:56 +0200
Message-ID: <20260421102603.4122332-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e9ea27-dcb6-4ecc-3b93-08de9f906673
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 3S4c05zqIYt6zqCZu0wq+PNfQMUyDixLgEbcDDJSl+8E/12i97zm7sFyPSPeDlcL/SIFKtOhM1GfRh6yyJA50/oUXUVvm1S0wM+rFaDSM+O2bEFKnWQVd+3/PDQvS+TRPlKhiuMr65ZgrCrajvNWyorAYyy19MTlwxglgmSLxqQBuRODsfgoDZd/iD3fsC743s00RTOmNXq2P/aNivqrXsf2slPFr1aIpBOAmkLwlGPHUxXUWEKj4mIUdLXaHgcdpv8k7WERB5Dc00GXSXMUGKUzn55lmmsKlD9Slsq3BAp4V/ssZJr39CSYD2u3/PBNzI6rTEMo4Bm2lCB/986gJpoVgGqs741YraxgnQHzPIqyCx95FApiET/gVjn+89Ww0k5KZC1V4iNJSIlLLJ0dNr+fhiGBeo/SPAqaQG+wsxQPC6TUR4J7zZnJclxrr8Dm9sqCvetE50KmJ48XqClEV+L4gCa0hsQY09XGCv/8daOJtBhAHM++b1rZTpu/XoIRTUsWsYzxCAj8TVHpxaX1dL2Qw2noiZ9qfjJkxUk4ZnYU+25uqjx9WOD8wXd3P4Ook0S4zDsNoNxtprIRVZKQI8lWt0477u1um5CghX+gP1LikrkSqItt4PSN+9SCYD0PivKnpF7KpsFZ+Q3JlcCZE41QDHLQX3Fy7++KgWTN31weeLzQ6gB6/kLUu2j5wo8omijNiG7/Lroec6JRPNpFGeyx+zi8dsPYjWs2/gjodzw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?blhVSHNGVU1GeXJ0VG9vOG5vMmJWSVJ0Tm1BQXBRUm9sbnNSd1BQcnFHZGdh?=
 =?utf-8?B?c1dNZzV2WkNKREtjZEtpZ2VsVEZla0d0NXVYUFVVZXlFMWV6ZFRUSHgxdG1t?=
 =?utf-8?B?WU1SaW54cFhMTStoRnFyTVMwbzNJVEhjZHAxb1VDT0huSWJ3TWhZakZlc0VY?=
 =?utf-8?B?dkw3a2JYSkVuNDYxL2tjYUdSUlB2enhFcjJJbVJmRHF4dG5ra3dqbER0T3ZJ?=
 =?utf-8?B?VHozNWZpellxay9TeU5nYUtLTy9HaXZDcGhXSm83N0h6MWdQRDhjUlpSSnMv?=
 =?utf-8?B?a05Oa1c1QlZ5ZXRnNi9PeXAyWG9YdmYzNk8wdEhLSHlqMDVBZEZibTNuUHp6?=
 =?utf-8?B?NTljanp0UjZIWVc1NWhLWUd5M1l3MkZvem1jRWloSXBMMDNqOFhUdUkwNTFa?=
 =?utf-8?B?RDBPd2lCZ3lobnF4VXNxenplb0JCb3hhU2l5WlZ5RExUZzNTTmgxZVhIVVNY?=
 =?utf-8?B?N0FFOXVrTlpZclhvcnpBOG1wT3cybklQVDdZb2I5UFA3cGFrZHA5VUJpUXc5?=
 =?utf-8?B?dHljQVExbnFzbE00ajBPMERJL09qS0hCdVRNeEhLWC82ZjNaMlMrVHVVNGlI?=
 =?utf-8?B?UVlXZ1BsbzB1QktvUlE1d09HYk9KaHE4LzgzSit3aUl5Tm1Oc2QwdVlRYW5V?=
 =?utf-8?B?MGx6TWljMENoQ0VOU1l1L21TNGx3RGpJYy9LMGpqM1pINllLcTdETy9qOXQ4?=
 =?utf-8?B?T2VabExQTEkzM1VTMTNmUjIzRVJ1MFg5Z3htQ1BvSnlEd0E4T1JTemtsUEF3?=
 =?utf-8?B?YTh0ZUZUV0VJZzMwWnVSZUNVYm94YWxFUHBOdE1CWS9aaCtGZkRkMWZlY0xF?=
 =?utf-8?B?NU41MENjWkhmYzBTMUE5djNWWGtGWHFPdHZpaUp3V0lVc09YUkpLTkNRUFhM?=
 =?utf-8?B?QWRNVzZQSWRsMnFTdXMvUDh6cWwvWEhXYUNtODRrSzc1bWRtQWJ3RkpTM1VJ?=
 =?utf-8?B?ZWNDTTh3SmxPRTJjQnNVTUFzN1UrQlNPRGtGaEJZNjdmKytxelZ1dy9KQjdm?=
 =?utf-8?B?a0swMXI5WE5zNXQyMUxHVDQrUlVIU0ZtRXdMTDZtbktaa2RVL0M1ekJIaUdK?=
 =?utf-8?B?OGlLaXJYRFNteUpwWHJ3eW5XajNsYzhVYzl5Q1VOYVJESkxFWktGTjVMa2I2?=
 =?utf-8?B?MmJra0tYY3FNeTJlZUNxaGRmaVRwVnNvQVY2NHpLbDVVZUpJdStoU0JnRjRu?=
 =?utf-8?B?VXYzOTZqRHAzdzhZZzFMUy9ISDkzUWtsZHk1b1hvaUM5NzcwU1JscEdnQkNX?=
 =?utf-8?B?WmNKSmtqZzBmTWVjSkx3dmFzL2pPeUZrK2RhYnRGNzJiT2NsckN4Z0pGQTMr?=
 =?utf-8?B?VjZydElXOFplUzM0MzJ5N21ZY0hCTkoxOGRQTkFsSUdJZzZQd1RiT2l6d1d6?=
 =?utf-8?B?NmZJdGRWeUh1NloxN1VtRWFWYlE0NzVVWTE4akp0SHpqdFJnSFdwY2VLU1JD?=
 =?utf-8?B?VXhKeUtVRU9YYThYWDY0ZlFoc1dGWEhjU1FGYUt0MjJUeHZ1WU5rUlVQQ3ln?=
 =?utf-8?B?ME9mVWRSWC8rTC83YmY1UkpWdnYvd2ZkZXkzNG9RVkxCZmhjVnhlcFNDdzha?=
 =?utf-8?B?TDZhd1VnSDNqYVk3M05hU0NSMmtmZCtBVHZaSjhWeGxiYWw4dGJ6cFE3SVlY?=
 =?utf-8?B?Tkp4ckJlV3FCN0FIZUVWenI2WExvMVZuMm55YnJWdGdjMTdaQ1BLYkZWTlIv?=
 =?utf-8?B?empza2hQODRzdHl6SXNqTEh1dTMyL0NFTDhlM3NjeDFvZ3BIMGZlQ0NTNXNH?=
 =?utf-8?B?VWRRbDFaSzYxNDBTeEpGaVJlWkgxeDI3dk1tcFFScjY3R1oweFQ5LzZieDM3?=
 =?utf-8?B?MFBTTHZjT3ZpTDlYeG02a2ovQ1hZcjNWK3pDU0dsalpCV3UrMGZzdi9hYVNv?=
 =?utf-8?B?RVE2eHZzUm1JbWMyeFZhN2ZIbjRKRURyM0hFdlVtL0Y3dWVycDBhU3BWdXBs?=
 =?utf-8?B?d0QzV2ZRVTJCZEpyTExHRVdvMzNJcWRZdGdneHBvYVkwNFpJcWdaWlVDdDBY?=
 =?utf-8?B?YWkwZ0FEbjZXTE1ybzdkQUZtbVN0ZzI5QktXNWl3RWx6blN6L3JqdTZtRWxr?=
 =?utf-8?B?Z1crdTFaRURIRkZtR2VhTm1PcFdsbk8vZGZwMGZjOEFRcllaampEcWNJdU1a?=
 =?utf-8?B?UVFBRXN3cDhycEN3ZjVXMFQ2ZENYZTVRbUpMUlFCeTBFclFsM0xFYTcyWitx?=
 =?utf-8?B?RWdzYkZiT0FjbEVGWFNrN0ViUWJJczh2aGt6d0RxejQ0S1BjdWxlOXd4WWJ5?=
 =?utf-8?B?NGRpM0tvSis1cDRkVTZwbmVmamhSSWJtSWs3akQrSy9yTjVJODN4dXpFeVd4?=
 =?utf-8?B?ZEZ2UW0ySUlaUzJjWDdJWTY1NGVGRC8ycm9ON2pHMHhBelNuUlBXcnlCS1dB?=
 =?utf-8?Q?8oVSM9g4EXFePIuE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e9ea27-dcb6-4ecc-3b93-08de9f906673
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:07.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coXAfLXaSl8qsnYYombWlzQFV84xvzROY/csAi71qaHmP6W3M5sRuiIBeQ5j6hgMQY6SjBvhB5pDPclx6fBoELtII9yo6pxCnAcBV3ak2oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7382-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 78A394397B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f73ff442d530 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0


