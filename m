Return-Path: <linux-can+bounces-7131-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBtAGkpxumnRWQIAu9opvQ
	(envelope-from <linux-can+bounces-7131-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E921F2B9197
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 152C630C811C
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DD3AF664;
	Wed, 18 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ne0RqCtD"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405893ACEF0;
	Wed, 18 Mar 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825752; cv=fail; b=V5Jhtgnk4oTVfwU/JZ0xi01QkUMjRM7jJn/xQZQbLCy0VUP2A6qcFtYKUGbi/u37ZEoVZCyqZd+ff+l5iYr7oVUJ43L1n1wpolP39Y5WJCNBrtMoyMFXvtQLib4B2ptxvJW8w2MuJzy3NOwmdZUZgWoMxTD3yZYVQRJPqzey2V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825752; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbdRWB+PBO2tleTfp5FFR3kdxZWQOQZltV/DPlb+X8dZmJnZMEZ17ljHM1tzQiQWZKr1LSqWKlIZruVrVm/cenF5W41BgR5pq05EsXyxdUJTCnfzeNpYLOEVtBTT5g+n4A41MuwB17KNTTEwCP6qarP0tL0FIEIT510ehJ+TO9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ne0RqCtD; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awnrbrab1tLvcGyfjvRcfEDlgVV1txN79Z1VLZdTRTmHxqgpk7M9AXIIVSDYJ/oasSopAmF6QrwN37BL4Np28MM0KlEhFsV4zyIMrcyv7pY89HJiM2hD6zWPL/BFWEtw5MmFwWfBG59V7e/eqmuUTIEBBqwOuQGYuA2EsiCpLwJHsssf/mzGjbo7v9P7BU0tZWqN03hKX0t+/OVzMSvTST/VlbqHjSvrIBGwkZZG3G4n3VWQoKAgGn9jaTDVmv0Jpkk5n8x1uomLbdS2jJmNAfKH1xIl1IjP5sYeRcaX+rNng/BsZYvmZCqsEvJXLPibtsXRDjHSDJewcn+aKQo8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=dQ1j62xjBaue0DYPjDyZoXc0IuEj1gQrD8+8Y21sXnu+UPyljVrBMnW3s6xjFKPWCcWQ8RR8u9N9A2uzGxVGJvU+nqOodkVvcZ6lsTYnn8WlzNoZue5nCYNGAzwWlisKF39nWkYxLjVfjkxgHaWwfzIestfJu3AjJYa6Xn6DHf4ZlmtVV20oo8mf8ZOG1sguhSoWzflFNOBd7J525gya3whRJfpzQ0cs/ayiL2aEj1bD+R7Dz/gTKp99BLTxiuSb4+BR0SYL0rktM7AEkVj9yjKbof6dY283a6rsRo5zW80cVfdxqNzhErQaEZL12J3UYJFBEbWyJFk4JpQG5DsrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=ne0RqCtDUpEHnOajDWdsyUEoWRsvXo2E7r06DKI2Uy+tVYd903oDTbXZJ+HzOh/0Jf/vamRQWdp1y8wIlpEO4tX+HQXWEoaNMMUF3E4zzWyGYbRImhXM8J2dU1WHJo5YqvFTwl/KwIXUYLtBbavoki9SPYSE7ie+q/Hipt0jqtBL4lZRdK+8RTvTfaMAhnSl0iOQSIsePwfCVFrrCPHJJebgaguL6i/QjbMR723R9VGwkQ0A27IcOfMZDC9Hm0CSwoXCt0bghLLEZfVJYSdeIIXArPYnKfaPsICigkdZFn0TgnpYpPW9m5QGaJFsy7kceT8P9KgLgD+kBaAKdDlQFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:24 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:24 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH 4/5] arm64: dts: s32n79: add FlexCAN nodes
Date: Wed, 18 Mar 2026 10:22:14 +0100
Message-ID: <20260318092215.23505-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bcc2fc-b78e-4710-2655-08de84cfdd3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pwpkiL6tTPBDAJhQtLl+hbAWJfx2ydYVpe/p8GMmNicgg6Ut0BAiqbXAVtQZSYh9as55vncgda/JjKheMZJh6IYqrliDP4TmQZaUukBf4qfd/NcDR4SZ1KhmgBgiuPoeloNJJMQciyZPFd0nNtwehBcfrD07PO2FnsqNyXaailNpfeAMYgtbeVOpaikEPbAIS0bbdlQGCb1XwQUfdlEASCHuEF94ODuRCGE3I9DtDpZhSSqfjXRwOfcy4CT9ZSgnlld53k9sLKaexTBlCi6Fx7r3t77483ZujoSWOFR6+XDJFvW8DLqFSf91Jw+6HRXcIf3VlrQe8jcMt070hPJTlFL2a33ZbpqRwzPymN5OsewMY+KOcFWnTXL/lg7W/FVL7yYVQ4bEH2w7MGLLpcSwhnaOIOltNl2uf2ZGcsLgLHHP6eK6WxMUEhSdAIALQCcUyHEu5fAmEl9Oa7V9+X0fNK7MfJTIe+u0Z8xWWjH4hNlgJycqpGyOoNfnZLVPu7XZrrg2wzolPU/YsFp5z893XbX8+6GFxwnS+8AvOgf4WvxQFemXmscqNZe1+caFf2j/1Dz2ZOenMPcThtuUsnaX143Bw6V7f6A3/9uzYeoghi7FxmWunaEq92rHtiC2U0usn9uRKsJzCad5uYddO3Bdjv6vD3kbuNugaa/Ros1R+MqiKSOkmQZa/eQBd9AFVemanAjbWHFKWBadZWi9o778fxNqT8FO11L7SeUv/W07vyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFRUaGtWWTRqcENqU1VQTk1qZUlVaW54S1duZC9kSk54NFRDRmc2Q2xvYlN5?=
 =?utf-8?B?ODAvclhYQzdDM2NyNVlHcTZ1VnV0NTRRcy9iZnMzTTlEYkVWTS9qWE8vdVJz?=
 =?utf-8?B?OHJRT1BXYk1JMjBqRDdXWjRabFlUaFUvelBUVEIzaGhnZTR5aEE3SGM5MGZH?=
 =?utf-8?B?dnBJUUYrdnhreFN4YzZ4RDdWYkRvL1lrdk9LcWxVbWNuQ3NNMC9ocjJKNDNs?=
 =?utf-8?B?SUh1ZXhvYVNzZmZIYlZqSDBiZlFyUmdTTUR2OTZLcUF6Vml0S25DaFZGNUxm?=
 =?utf-8?B?VlFQZDBObUx6YTJMOHVzSEFKZFZFS0dmWVhMVkFvSXFsdFRWb2hBNWZTU2RR?=
 =?utf-8?B?ZXA3VERkVXJudzZ5TXVQNnlnaHFNRWVvZWZUaVFxbmhha2t4NHZ5MEIyU1Yy?=
 =?utf-8?B?Slg4eHFkWXpsaUlJMUh1N0ViOHd5NGNWSjhUWGgyU0NoU0RUUDlUMGdaVmt1?=
 =?utf-8?B?eUthNG5pTy8zTWgwd1FFTXhGbWlwQTdPTHBtOUtzemdMNFExVzZxYmhOY1Fo?=
 =?utf-8?B?U2JjdytjYWsvQWM4N1h1Tm1rZFk0SW9jSkcrZHVldmRzZzhMUEpyUEhoR2tQ?=
 =?utf-8?B?bXBTUUVCemdWM2F4K05KWlViTTNBQU1TdmorRklyY0lwZFFwcVlycnl3Q2tw?=
 =?utf-8?B?RitKc3JNa3JVOFRYUm9ZTytnbW01SGxDR1E5U3hnbzc1ZkVLcmY2cCtRK1By?=
 =?utf-8?B?Rzl0MHZPdjNGN3JVcjRoTFhjeG4wb3RraXpmN2xPZUZVRXFIVXByTUZxNmU3?=
 =?utf-8?B?VlNjaDZRZDJELzNIWDJVMlZEVWJpQUhaZEJmRHVYUmR6WDRiOS8zaVR1ZzJ0?=
 =?utf-8?B?RzFlS1RNVkRqY3NPSnJoajlWMGwxUENGNWRhSSs0MVRGaStpQ1dSMTAzVnll?=
 =?utf-8?B?c2dGaGY4b1ZSQUJkc2d4bTB3YnZzVXhqeUZTRS9FSDh5alQ1LytCcTY1SVJx?=
 =?utf-8?B?ZVYzcC9la0c0WXk1YllNbjN1bitIZ1A2bXVmZFJWeUU5YmZ0VGRLVnNNOEE2?=
 =?utf-8?B?ZHFnTWZJbFJrZzJrYkc0ZXJsb0RHcjVabm14RnhjU0t5WTY4byt2WkVHQnFW?=
 =?utf-8?B?TFFZRHRNaGFyS00xaXljc0tlMzRJMDQwTGF5dithdFZHcTdnNUd4ZVZtWmNQ?=
 =?utf-8?B?MkxmZVQybXEvOWVCNStxYVJtRHpoM3dDR0xKY254VGhvMzBvdVpQTGs1NW9G?=
 =?utf-8?B?Ly8xV29CM2xZNnRxM2kvMWZOMURvcE5FWmdUMUgwOGZQbU5xNjY1VW44TG1G?=
 =?utf-8?B?aXNhZU85M0NkMlVhZ014aCtNN0ZjVWJsaExRc1pOZkp1V2Nxci8yVW8rOTlU?=
 =?utf-8?B?TmNRcXhnWGxUTDIranBFSlJZQ0tVTDdwM1g1RmRmVFlQcFhpMXA1OHplaW5B?=
 =?utf-8?B?U2htc1JLSUpoaWYyRm9FRHlKQm5XMXFlU3FpZFVXbUtLdVpBS3hGSUN2Yy82?=
 =?utf-8?B?ckNvUEFLQUp3eENJSnRPa2ZScVhiVE5zamdTMzZpVUFOZC9ZMmt2WmNSV1dB?=
 =?utf-8?B?UWIrb3hiUllVWnYwUTJkcUZ0VDYzaklWUXNZYWRJMkxMcnV0MmdnK0MveUdw?=
 =?utf-8?B?S2hjZ1JDSGJLc05JSENYZ3U0WWZ2NFNubk1DWUM5Z1RRRUxkOFFuNytROUx6?=
 =?utf-8?B?YjJlQWJnSWNXLzN3bEdrYjMyV0ZnZGZyTkxSR1pRcDhtaVE0UUc0R2ZHYlpK?=
 =?utf-8?B?THRTVnlzSkM1WHNqQ2txNnF2S2FBYU1vZzIyUlloUXQrVWlKYkdBZVlTa3o2?=
 =?utf-8?B?SmJOdEhaMmdOdWFGTmE4VlFuQy9LdnFzZko4VFg3V1VFQ3ZTMURtaEI2WHJJ?=
 =?utf-8?B?OHJyRUgyK2FSTm1oNytDbzhhOVNBN0VUYUxUOS81anlMVHVLVmhtZ24xUG8z?=
 =?utf-8?B?bFp2ZUI5d2x4cmdnV1pZTEZ0cEdVblFYUGxmajVZbzJYekdRRmg3cXZEY0RK?=
 =?utf-8?B?a2ZVMFUyYXdleVNDRFlSTXgzRzR5d3hUREpOOGVPWElMa0xtNno4RFdhenkr?=
 =?utf-8?B?NE5oV0dsMmpyTW84S3hsWFhOMEhKRUV3Uzd4ejNWeDFTb1pHY0RUb3R1YUxM?=
 =?utf-8?B?RkRnVlZsM04vS0J4eXFFbGhpTEEzTFk2QXFrZ1pFcWtOVUFzaUtUQURjTmxQ?=
 =?utf-8?B?b2NaZmJFMmhEeUtBWnErNlc1WlNPV2c0Q2RnY04xNWZKREUrbXFKTE9TYzN3?=
 =?utf-8?B?bVdEeGNiYzN3YTUzdkNBVHZjQzd0YTY1bU1BanJFbW94aGZ2aGJIeUN4dG9U?=
 =?utf-8?B?eFRtU3M3VElVU0tDVkJrdFBsVzJsVnd1UkJsd1pOZ1JvUUtnV01sUTBBMjZ1?=
 =?utf-8?B?QUNHdDZ2dnJGaUFtWVRDT0lzUnpUK2tlY1FacjJiekUrRHpPQUNsTndGTk1U?=
 =?utf-8?Q?NmyIC0gTbsQNYIFA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bcc2fc-b78e-4710-2655-08de84cfdd3a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:23.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYkuzA0NIMrqkJBMgTftMw5D//Hluszsegc9FHSs+U1IH1sQqDF4NYCKIv8n3EElcTCpdVO6p6IAX04wgDNJ/PnbQ0UM6DTSadkZjKQdbrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
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
	TAGGED_FROM(0.00)[bounces-7131-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[3.72.198.72:email,nxp.com:email,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,55b70000:email,55b60000:email,oss.nxp.com:mid]
X-Rspamd-Queue-Id: E921F2B9197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


