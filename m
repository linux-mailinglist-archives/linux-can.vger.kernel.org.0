Return-Path: <linux-can+bounces-7221-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPUJMJJHwWnpRwQAu9opvQ
	(envelope-from <linux-can+bounces-7221-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:00:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D592F3A06
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBEA0301DED1
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C13AD538;
	Mon, 23 Mar 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hR6ph/fR"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A93AEF24;
	Mon, 23 Mar 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274315; cv=fail; b=Kot2CMsY/1u8+MtDQZmIaTPnXt+dCiAQwFFX9B1Bi8OW7xe/teNc/KdLGt8zGOBFqPCV3S2d9zKky0hgIlV04c23xnYxKC6TxauZtW1OW3jrY94Fe35NTulkS5wQj6vYXuO/S1JRosXnMhyy1BXBN9x04CER+ywAyP56oMpyy7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274315; c=relaxed/simple;
	bh=XYaPuZHKxlf2fOPuwmxC6+4Pp+O9f6USSAuCHKPSr78=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PqzMRIDgNOKYJVkE+dNXp6ZfIotPyXPpxkaNOs0oekjZPunIuEzqclXkPj9oSvo9J6szoWackMNDeVedHIdPEQENLm7+0FWNdET6XTcwHtGuzyATucwm5U7NIXaiZVuOXY9MuyZoUZYoyFPBWewyS8fR4rmJr6LnTwzU2JuGftw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hR6ph/fR; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHotidL5sVdfcv/bv+DBuLBEvoYmPXZOnscpTBFaBPebPS+woOPh3UxaUOvU59wKFoVk2I2lClejVYc9Ke+xUVMtqVKYxfiRz7JxtyVW6NESc0uU40De3SO2oD4yL4Gq53fx6ahRmssKUU3QAFst+oMksGo3FgE+zIDSCRKLnhUtGhZQJnGY/mnFEtGdz/ui30StJxvnV2JOxKebKPdEytycPkMTvtwVLh1cHVudrFDg4hfiFqdQsZQsKoGmZgCprbatzTQ0K8jDKrNCtOHuiW/fypQZgMTA+NzBrtPm1dv3ErGcmPcXI75XMSgXDcX7hzuE5yRkYD6siCKQI5aCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acIHdoTAlVhpksOruUBX4RDNVPGqn3uemg+LsN7+6y4=;
 b=lM+bHB85booWhLaKBdtlZhsF4YTWdrtrPV6BBoW4dW5f5rJDJvThqZjVUfkMLwrlxMiXJjim6iQCaL1Xn62oChQfwmh0MKBpF2ZM6Wu00kI+YJvsBReytjwKv+bzYZoglJ7JZXnwpi+Hhx5l1zuFUm8DwgbPTUzL5kVD0ubMbVByoc6WrfUMF3iJKKA7B41bFTR0u67ydt4ZeV3AWKOqEvo7oh8R3KA0tkNx3J8HKjhkw3m6/S1YB19iHnbQyOW2t6AaL1xFfsScTpiGNb85hIblTDdhFYNt7g7WAvS2cGo0MbwkWAqMLO6oZHcXeOCPRFsE3ZK8FwScZaf5OTg8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acIHdoTAlVhpksOruUBX4RDNVPGqn3uemg+LsN7+6y4=;
 b=hR6ph/fRrxwb3VQhPsoVjXa6AJ8SYkRSbMuiLF7ZH9MspcXrk12u6Gnv3dUk10ucdvqDYPQfIXsd9OQsAguD6kD8SAS1DGNk59WK4ysm7d/vSvYIrCxPaFBXol5ccJzrkAELVezY6SV9aL++uwMSnVavIe3G0IWsedg7M3xSUj9+JRhM88vRbmKVn3VVh6waf//y1iax5xKI+4NR4hmtSt06p1QIE+sPYpn+2FVJpDZoZWxfTKjNzzKg1nTO0BoRvScMjm1+6QnqAO4o9UcHvPYske2r/XZHM3QzVYIEXMWbYSOlsQ58Sua9xjRgMG8YONNLEwfGzZMvHO7LPNjkDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:21 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:21 +0000
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
Subject: [PATCH v3 0/6] can: flexcan: Add NXP S32N79 SoC support
Date: Mon, 23 Mar 2026 14:58:21 +0100
Message-ID: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0064.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af57169-7c72-4b74-d97a-08de88e43e0d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xXS8bbhXB07M4JOYF+zMaD5uk1n7M8TX310LVUMvuHcHocLS4uWffb5R5nQ6TMgXERiJ24EFKi2tbOBjAc9Cxn62PurXXWQozvEecS4Af25DnXJhn64HGmPUrrlPHlAcB5xbB7TbrEvzsiJkvGkxjMYOOXadbYjwIjKDadHDyIld6CUaFKJWxZDzbHCmmbNrj36xEVnux/QY5WRvuFhosJvcHdiIz4Vu/JHX78xq2yntldP7ciTgiY3yLAGFW1rXUyIcevFrIWPgKM8FW+kIpCKKb8iG8v7gXmKXerwjWyvOGMx3by7PJ60RGH2iMlPvj2P8LgPEw5dL+P9kpbLStE2FjRpSYWu1+bSGeUXk31EHbyAHAVBYfWswLw8Xzxcslrf3rwh+ukZlE5G3AZI7hrAMZYGArTMlvmhEKrKWslK1I75V8mR+Ce8xwWFrfR09z5bhuXbzgtfBe8+7CM9nqK+rbEXNbhzPVuxpTAG+F7Vr6k2dhYG54fJ0NyH5TYJVX4/0oxVYavC6QrDaIbbdOT47Vu16nmrhsxm7MLVZWCwR0P2BKolYM6aqnQkvexsCNazadAQNmEtj+9szwFf7Svnw2UAUhpbhsIy7lY0kgVIK4tTJXXRJl+JeOSGOaDwRKhJVxMsZBnFFm8/3Psy/cagiQf36ExMS+ypbV5NJv5tdAolLbM3OQdespD/OFFM049b1RG9/LwK3e9W2EZadrMzQLGN9NYKUIdhs+FFQLLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHF4RDZ0RW83d1JVUEcralhLMjlnVXlnRHNnUUhON0FQTTVnUC9YdDJNVk5B?=
 =?utf-8?B?dnNGcU5EbDZWT2lTVGVac0J1aXlTR1ZscFAvVGRSNCtNMWVPSlM4L0VUem1r?=
 =?utf-8?B?bUpmVGdLcnZ5djMybWtkajdEYWo4c2QrS0NxVUEzVGUvcWFObUcvZzFRS2Vp?=
 =?utf-8?B?d3p1WHM5ZWVQdEJTNnlHeFVLcFhzZjBRUE5CMHhXVXR6bXlZTnRlbDl6Szdq?=
 =?utf-8?B?VE92eWlINjZ1d1A0RkZ2ZWNPYUZ4ellyaEM2S09wTzF2NWZTYTB2MHNuN2g2?=
 =?utf-8?B?WmJSOTJJelNNSWMweEFtUHQxYXZTTUVPeWNWVlBFN0hZV2todWdMQklEY1R0?=
 =?utf-8?B?YmlCb0YvRHhhayt2RXlERTVsVTl5azUyaGJyNGlFWHQvRFoyM1lNamJJN1Ja?=
 =?utf-8?B?dDFHY3FOYTlCVVBVVXYxYktlS2JBNjF3dnpYMTA2N1hldllrcUg0bWJaSGVX?=
 =?utf-8?B?Mms0bkdvcXY5VkVDRjdDbmRGYjV4cWdVWDhQOVdNK3E1YmpCcEVjd1dIVURG?=
 =?utf-8?B?am1uVjVlV3NXVEdRdkFyRkZUTThVSGU3aklIS3oranZMblVOMWNRZHZoMTBy?=
 =?utf-8?B?Z3poM2NEVXowZDZscGIxWStZL2xSazZtRCt1ZWREcmgvWHhraDBSOTd0SUZl?=
 =?utf-8?B?UHhIUE01K1A1SDQ1djE1MmVQWVVxeXIzbGs0LzZOT0M1TnZ3NHJDY3RaTTRx?=
 =?utf-8?B?K09yN3B4TXIwT0tNYXFaajhpa3NSTk5KRzlRNFAzRUN0TnZYeitCcCtPRm9a?=
 =?utf-8?B?R21CNHVwem9zTWhFSTJMUE0yakUzcHBYK2dQM1ZkalZjL2VLV0k0bEVWUjVa?=
 =?utf-8?B?ck83QjBXT3VVOUV2bXlsTld0Yy9aai9nL2VveEZCY1ZHNU9QcVBQWm5MUG1l?=
 =?utf-8?B?R0p6WWZ1WitqNFlvWmV2TXAzcUZpUWYxOExWMGwvanFWLzRYaU9ydHB0dmpp?=
 =?utf-8?B?OW1NQUFQTUNsTXVkTmYrQ3Q5N1AzWVVPMWVnSlptcGtNR2ttMTdwaG9vTkFP?=
 =?utf-8?B?eWZxWUhacVZ0Qm9MRFZJSmVzR1ZnYSsvRkczUEZSZWd3UktzeW1Eck9TZlNx?=
 =?utf-8?B?ZG5FRy8xSnplTVQyUjFNQ2NNK0dLaUJ2ZVF1TjRIMStULzZ1UG1yM3B4SGJi?=
 =?utf-8?B?TzNZdUNYTTg5MVpBeHRxYzAvVThzTHNqY3kzZjZjL0IzWVF1MWt4Wm1hT203?=
 =?utf-8?B?aTQ2ZEptTUI5WVF6N1RBS0UxSXRldFJtRm9WVlJMUW80NVgyUHN1L1hTSmVZ?=
 =?utf-8?B?TzREWDNyMkgra2pLWXN2eCtNTFdEcXdMSnRJVzlyVXZQSG5YMU9VejhTNUZv?=
 =?utf-8?B?a1JneHRrTXpGU1RQY3BmKy8rMnpPYkhueGY2Mm1XVXBVWHlKcERUdE9OcXZJ?=
 =?utf-8?B?VmJORnBlWElJTmU5VmdQb1I5OHd0WmxDZTZId0M5dndEejBQZ0J5YmJzZmxD?=
 =?utf-8?B?YW5HWWpjN3FlTEFZS1NwdTBpVVV1UnAra2QyK3drWjhobnZxcWkyNVlUL2Ra?=
 =?utf-8?B?eVN2aWsrVW9ZYjNwZ29JTENoWmZLZ1NKcVhzQ1lJbUp5RWJoRFJOcDV2Z2hJ?=
 =?utf-8?B?WXpwRmNwaUhMQitSYzJveU1xKytBTm9JbUxJRklsdXlyRU8wdUJTczM3Zzl0?=
 =?utf-8?B?SVhxR05YQTYzdWpCem81RDNya0ZrejR5UmNNZ3BuYjNYdUJvNGxLaVhiTk5P?=
 =?utf-8?B?bmlINUtKcE54dDA1WE1nNTJ3S2xJeFpMU1liNVRwWW1XU2QzUHkwYTNJcmdX?=
 =?utf-8?B?OE5CZ3V1cUpYUnd2bjBMc2dnclkwV3hwRWZ3cHZnQzhvUG4zc0pLbER5S0Nv?=
 =?utf-8?B?amx6MUp2V1BUeHBiK3Ivbkd3dmZQZVhnbVhQYkdvaW5BM3VTbVVSTXVtQ3c1?=
 =?utf-8?B?TWtPUVV4Qkt2RzRPcm1HbHo2ZzZiZWMzNi9OOWpqbnk2ZTdlOW50V0E5MHBP?=
 =?utf-8?B?bjlOY1MyWVh2VFIxUTFJT2g2Qlo2ZWg4V3pQeTZ4WmFPbTVscmtwcnVXMENt?=
 =?utf-8?B?eGNVVUUrR2RYN3dZNHJGZEZuOFd6VnZrR1BtTzkvZytLcDFvaFFEMkpGNGRy?=
 =?utf-8?B?S0VpVzcwUTAzWXdXSlBCSGNOMSt4YlY2Q1pVWUk1T2t4cjlkVnNVa0hpaDly?=
 =?utf-8?B?RzZwQXFrbjhjZnJVbjZoWjhaSmczK0x2Qmt2TElPNFRqWXRUVGVxejNrWXQ0?=
 =?utf-8?B?TENMV3JNRHdSSGJZVFdyRG1OS2JtUG0yV0lUSzN2NDNJSytaaithYVNFd1Ev?=
 =?utf-8?B?aVpwM1p2ejY5OHkwbUpzMjhsTlJKUlBzZGVPTFBDbDNFOCtNYzNxS1ZQVHl5?=
 =?utf-8?B?WWVwR1RwZm9pcUVyZFVxd3M3ejNUNzhhVWVkU2czUXRQOXJmaCsvdHkwVXJW?=
 =?utf-8?Q?MSVJv5GboiO/LWp0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af57169-7c72-4b74-d97a-08de88e43e0d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:21.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lIy0BSRpGbB8Y7uTQMBQTlvhPR94Eh7aQfyMAFoqUOpCfybRALqush0qwa8kWDmlFzxe/npdZy98aTuqi84Nx+lBSW6Nt/w9W7IucuTcyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7221-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 03D592F3A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings


Ciprian Marian Costea (6):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 ++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 +++++
 drivers/net/can/flexcan/flexcan-core.c        | 180 ++++++++++++++++--
 drivers/net/can/flexcan/flexcan.h             |   2 +
 5 files changed, 253 insertions(+), 21 deletions(-)

-- 
2.43.0


