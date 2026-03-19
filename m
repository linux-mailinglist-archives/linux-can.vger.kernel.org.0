Return-Path: <linux-can+bounces-7146-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HoCNSXFu2mYoAIAu9opvQ
	(envelope-from <linux-can+bounces-7146-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:43:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6A2C8E49
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBC4A300B597
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC13BE178;
	Thu, 19 Mar 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s6aoMQ01"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5A3BD24C;
	Thu, 19 Mar 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913250; cv=fail; b=ZRGLYHeq/poNa51NJSWpPVZl+aVoTd1arlk7zUdWbgjJ+s0b6HpLSAjah/XYooDR8u5zefu+Zc/cOHDvwt0l5ZG3UjQ9ozNLYZGjAA7jhmT1w0h2DjzLiwkssS+Tg2O89TUpF8OUyeONZ8tqeCXmClnjnzX+aAWHjA8FmTsQmM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913250; c=relaxed/simple;
	bh=WCZdMb8PeV49dR8IFLumMhMsgCljfUi1WUlLecAa6BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvlANoGqE6tA6a906x0J2iqrtVOIT+RtH6qE8CnsDVIdqhOhLJvK9HQJ1mpPF3CHr6upw19myPp4cGucJ7l3qrYyGMl4CY1pQvIUpB+lpvI0RcVCBl6MmpGzJFTQHK1o+8qFphCifyLicsM8bJzM8zIBzSvtfTTUekAYNk00pcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s6aoMQ01; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baAkK89BRYf/O1nMregClSg+H++WWDkiDQiNyoJPiCs1JqRNyrXg1yqOBAti7Ao6IdG6J0QP4uhyJY/gWL2u1ZcrShMorKpXT0mBWCPvGOWPmR0SddZ+G6cby/WANgeagYVBauKrvBnURwgJmt0Tk+ciWFvFIAXa2tX0CGmkmmedfKZvJNISiFG9WBPb2UcmcFZwxf88nuok8vNisnHwtQYgzPqcAGPLZidOVr+fL5yYKFNVvDSZG0+tsqpltQz3jxYNp2Bg5umQP8FH/7Qd6+i1L75pZcRTVUrL/gZWDxzrgow1mjSC+NC3W6EzLNi5C31XcLmsshZy6/Q9RHsfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e7zk/pHIvchStb9CBRNT4H8JeLImn+/teUgyx/pqyk=;
 b=Htd5kx50F6euerrYc7lu1ni28x7QPGz/09PTIAAjbTz2JBmVG3/oc54+ytA/0/00f0z1IdXlVRiSw58SqvvzG8u+C7XXMglTFxC+ocOdsdZTM47ntTQDjQaAzNHyXB+enIhaEraA+iXRyrKZ34qfVC4TMbQKqBQeAvtplGUk0eS5HBYSpiX1HGz0gHD0y0qi3RjACk7er9GIOBnKImAi30tz0HQD/jcpn5p3t1Ra+mVnpLdSvSu3vOTdpxRYSy7dAnMjvnaSOEa7S1N8+EKQBk6Hl+nQledOjWv/Q7X/79L/G2radS8nc4CEFGadoaYCbX3XgF/0xTnayP4TH1bHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e7zk/pHIvchStb9CBRNT4H8JeLImn+/teUgyx/pqyk=;
 b=s6aoMQ01Xx0vHRhbfgRWnEskI7TZDZZj7+xDARNWp4G3M0irSCpdCigV9b/hUE9XyEEa5UJc0btvS+sLShfy4ZATX4LCWwG4mlYizNcWkVrxfI1VXVAzSHn0zJldGXEdtw9gStN3qU8LRgb49jQyWxuXDFkeY+gACe806Pj0/v7yywHj9JmI2oxXyL/LGDs8uKtUjS40B4ljcMGRKeNPCn+CZl/Xnmdrj1rDdF/1wSoHPz9Ml03X7qI4WfCATvdprPoMKgtB9XzaMoOZ5dfTXasbrud3V46vzEjyEf+WdS+YMBdsNpY4aR2eGt9z0qcLoyM1mx5ERj9vhzWKPqM3uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:36 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:38 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v2 3/5] can: flexcan: add NXP S32N79 SoC support
Date: Thu, 19 Mar 2026 10:40:30 +0100
Message-ID: <20260319094032.427697-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d647d0-fb04-4587-871f-08de859b943d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6YmKF5PT0BuyWdmow2uirV5EkFBN3qbJsxfMkwgmSecEMgB7gfg+6dgnr+xV/D6sFtoAtHi6Ccr4O1/O5rP3F2ns7wqFAhsyY2EHAZfSrdWKQWEaGLbdFC4nnniCEIoS/pnXYaIB02kzqP0GKmkRPT0rsOy19eLWo5V/UdeV7QMw/ISq03EX1hcBvb0cHJeHav6N9bxWkHrv67ffArfdKfWIaDU79vE8wXUS55QMjOz8Fklxg4ZKHcsxa5ok1ulH7B3rxFD2912Y9Cr4iHq7xUfyLicV3b6/NXas/oVanL7q+YhReHsGNcsF/GFoaiLRm933EFZGymQSEPWHGFfv7VKom8QI3NXh7bqaubY0gbZ7jyJySkFYLhBN5ltefF2dtHt2Zz5ZnqF7EXLvLsvkgJj8RjqNHgBS2JHoLjSDzGpD0H4xsvTipa67nYp65diGiGhD/g56GLVYXZNjTM/Mw6KMzi0paGWr0oU2R9WnygYbCCIxqvLZ0l0UToH/XguxfbNnAzla1zQKq884sKta/2N20dbfN3M0WUaM7B46m9XLCF2lzhTFpPHKt6Ow3ipuOOlETcGj0/LuDih1ZWexbCaTbx9lzdY6PPu84ptVky1aFsUlmpwQstIPhlW73aeM7v5z6iNMg1EmGT5bwDtaIIayIlMQXe+T6U50tvoQ4W6nk4j9e29Hh4sRKArgHOgMlM4yhNdFRsswM1X/CScWBQFJkW05A6qi8utn+uE4bbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0IyR2MwVDgrTDBHZ3ZQdmFtR1B0ZWFrUXdzSk1acUY2c1VGbXdVaGVCa3l4?=
 =?utf-8?B?WWRwSUpOSXB2S1paMzZBZitWb3hianp3bU5pVFdJTHNMRTU2WEJyZGxZaXYr?=
 =?utf-8?B?Q0VuVkdjcTJqU3JSa2VjS0Jjelo1SkxFNmVjbjlIRVNVdCtBczNJazMvd0FJ?=
 =?utf-8?B?ajN3WGRvV2hUS2tzcXd0WU1tcWRGWlRBUGt4Rk1nNlFHclJZTU1CaUtUcDNB?=
 =?utf-8?B?M2RqcnRPU3BDemNWLzZIRGlCT0FwTEVuTEpRZG4wQ0pLK2lVQTRML0p5OTYy?=
 =?utf-8?B?eXFZMUZtdFB5KzhoVGVzQ2t2enpTenZjNzhab3Eza0Z5QmpaRGNUSEF4NWt0?=
 =?utf-8?B?bEtkQzZCTTZabEJmY1RrOWZ0RG43MmI2dlBUOXVDSFVQQTBML0ZVaythQU5S?=
 =?utf-8?B?NTJGb2RadDQ2UGtROFQwazBqTHMzUGpncDZYbjB0YUtlbG9UbjRUNnUzRU1y?=
 =?utf-8?B?QTBQOUxaRFAxZWpGZk9HOFlidElOVFMweXJ4L21TSlhEbXE3bmMrMmtDUlNJ?=
 =?utf-8?B?VGJwRHQyY244VFFUMkdGTlFpUDZzc21PK2lMZ2MzT0p6eEUxa2laUmJGbzlI?=
 =?utf-8?B?bjREdy8rSUtuUG9QRWVrbUQxeWd5RVR4UnZiTFJJcW9tRnJSZ1M0WWZBZVZW?=
 =?utf-8?B?cmp3ZEc0TCtIdlAwY0drVW9zT0ExOExGZUlETkVNekF5K1NuR2NGS1RHdGpH?=
 =?utf-8?B?T2NOOWVydTdMWHMrZHVVdUlndlhIdmR6SE04aDM5bHJVa2U2VHlPVzZ2Ykd3?=
 =?utf-8?B?anJWM3dPZ24waUsyNmRJRGtnSTd3blUvZGYya3R5dkRmTzJBclY3dGJhR0tj?=
 =?utf-8?B?dVl5ZHEzckFEeVdSaFdRZndCTUxUckY3UFBCamgrdSsvZTBCSDc1NDFtUkFl?=
 =?utf-8?B?Yk5VajlzOFMycTJsZG9aOVNwV2poVzNPcG9TcFhYcTU3UDRqMkh3dWczZEFw?=
 =?utf-8?B?TldJNXAzbDh0cENQSzNvTzlRcTRqUWRKK205Zmp5aFZSNkRhY1FFUUhvZTBP?=
 =?utf-8?B?SjdPaVBYREg4SXZrSWl1WkZ4Zm00YnV4Vml1VTNldThpN3I2T242VWRzb3NP?=
 =?utf-8?B?U1g2ejR4TnZrZWs2ZEFBVDRTRXBrUW04elFxTWxCRXNuaWRMd0ZvVW5yUXJ6?=
 =?utf-8?B?ejZjVlhkbGVVaCtiRmIrekJXNngrdmVpbzBtM0xCNDBjL2RJT1NhWUlzRGsr?=
 =?utf-8?B?dzBiTzFqcFNyWDJCSUF2UkpQdG4zMTB4aU1Sc2h0Rk1mSEcxblY1cGh4bTA2?=
 =?utf-8?B?T1dLTzBWNTBUODhMMXRaZy9zdVlrbEdlQXFqY0JFZDFveFY3bElnZkJQUHhI?=
 =?utf-8?B?UHg3Q0FqUGFodWxEUlJtMXYyMTBFeFpuSENzZmx1c2Vyd2VhOUlqTkhmVHd5?=
 =?utf-8?B?RG1NeXR1Mm9FRW9PcUV1c1FIbU9yaWw1SDlzVGtKeklUSjJXN1RxN0NTZzZu?=
 =?utf-8?B?M0todHhxWjlXSHRDV0grV1BqV0wrbDhzSUQ1OFE2UkpMQzluYmxUS3ZQZFdM?=
 =?utf-8?B?MGFtSTF6bG5EZm5kVElmUk9JUWFmbkh1YjFtWUM5K29mZ0tIRTU2VVZYZTFE?=
 =?utf-8?B?bTE2T2pqQnBTdUpMbWlxc3Z4ZjMwdzdKMVA3MWhQWFRwbzRsbWlqL3VDVndR?=
 =?utf-8?B?T2F2SDgzRzZhd2NzbVZLdVRReTFyTFZWMnh5Z2xLREpBZGpBRnV0cTdrOStZ?=
 =?utf-8?B?aXdVWXJ2TVRoNmlZWUN1aTZkSmZaUFYwSDdRNFdRemF5bytIanRGVElmVDRZ?=
 =?utf-8?B?cWRoN1lnZkdPZ0QvZG51Qlh2VVJHc1RSSDVNd0hxdlZDa1VEbEczWHdNUzZq?=
 =?utf-8?B?NHJVSHpDZzRQcFlQaWxnZm5hbW5ycVNHWit3Y3VYQ3Flb2NWYjJpSjVZcDZ3?=
 =?utf-8?B?RThXVGEybDdIckF3bEpyZVVnUmpnRTJ4WDV5dzNpOXFUbFJVK1E1OWRlMlVO?=
 =?utf-8?B?eFBJanl5N29XUGJML1NJdytEQU1BRlhBcWxMNUViNUl4MnBQbWRCRFBNSTli?=
 =?utf-8?B?Y1FvVHUyWjBKU3ZRUzMzRktYbzh0NE9VOGFaYk5WK1FSRjgzSGRGd0s1R1ov?=
 =?utf-8?B?Y2pzVTd6eUJnWk1jWCtqUitNN094cUlidStzVFdZWW44QUo4YVBSWHh3aTV4?=
 =?utf-8?B?dkp6aVhFcktva1JocnNLaEhiMlFpWDNlUG1LTXFscFRoa29laW5BTUdjRVNK?=
 =?utf-8?B?T3dPajVDbGFXbzhUM0dnOGhiT1RuR3RVNk9nNUp0ODdHdTJTTE5PMXU3V1BY?=
 =?utf-8?B?cHd6d0g5OXdYNDB0V1UyREo4bGlnMytxeVlNWlpla3M3QmJDV00yNFJabzIw?=
 =?utf-8?B?aXB1U3Z5VVJTYVFJOHlFcWlwcnphUFBGSGZJRGRYL3crdzM5bGVRdFFwaGZX?=
 =?utf-8?Q?xA2e5sXFp+1siO00=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d647d0-fb04-4587-871f-08de859b943d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:38.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oN8D33cLays2wzgUver6RoHdoRdLshKzR/yIh5W2lYTDLQNst1RtohjfUWunDwHFpatWCaokeQSRxXE9jZuYqWP2T8VHZP5GuJ2O4pq8ChU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012
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
	TAGGED_FROM(0.00)[bounces-7146-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 85D6A2C8E49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 1d5879510adc..0f8ad666df09 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_IRQ_BERR |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2076,6 +2085,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


