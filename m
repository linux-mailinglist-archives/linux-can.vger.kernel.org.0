Return-Path: <linux-can+bounces-7490-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBWPCcfD+Wk0DgMAu9opvQ
	(envelope-from <linux-can+bounces-7490-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:17:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046A4CAD9C
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 600C9307D944
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966F33D501;
	Tue,  5 May 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BiDZx0Qh"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668003368BE;
	Tue,  5 May 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975541; cv=fail; b=Ov5Fj4WuGCQbcIo/4TTreH/8KSE91Gv8bQyQAdK+4KprrZOaUQ6f0HgVE9Se431gZz3zsw4fO08eOy5kARQmP110NPtcvTWjn5Oat4zd2mSmOH5zx3toIRmy5w+0D3ww/0JIg1qD1HkQyIVi4Kmbprwce94K3HbN5eQSAQOSPgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975541; c=relaxed/simple;
	bh=52WfOApgZhgq4vYqoLAu19NyYZC18d/0hAWXaH14FtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VbgvcDQnjjXr0RzldR8wUldixlLP8ixiV+mnOPixhdgWhz2OjU8lcU9W0U2Rla/7OMqYv1GxRcV/jBFP9Lk2C4nDjRG9xTSd/AUNjh+vOksEozzi2s82J0/KgPNIOaqmXohv38m12Whtmg9C72nc4YS0eXNl5S5E6PcAnZt4/Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BiDZx0Qh; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjaj4QIImRPS+jmYPy115uiJoy0IwI9AosQSvi+2pA4eMrS2sw2sKgsInzsZZ+Y0WHW9PdJrntxHQEpmpa8ptb86KbmU3LuLjJxReG0H6Ft1nKR2OXE3uVDA9T/XbVwfJR9olz6ncpX6FKHizh9kRoI/Yt15QhyjX/AIJOAazuPEbDXkBqbpjHZZ2HJRJ0HsjvZdD7149XZmqn43TGJZEfJAl9RML9xmKw3RLdPcdqIlB51C/poIvVW4PzVNEkP7UrZIi9UP/0q5zc6963f5W5DugV+jpnEp1XBEYU3+hrF2cw3Qn//5Te5eNtb2jjCpmLGFcs+WuikV8z+7PqXXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgvdQDNjHvv/zsrLcjoCqZz5W4uogTGw4FSj0SzBEkY=;
 b=v88fmhrtW149Wx0IAJJB0BgC4eu1UyrjoIKK6oavX4RzfNASrBcksYmEk1NkkJ+lbPtIVfF6Jnpe69LftBFJN3rX2wfVgkDucHkoueva1z5Kr2JRQaKGdRpPPwCNrkRhUOY6ME/I+5/KNxQ+d4gwdYRJTtSelVM5sIu7q7VuSE5Dup9ca1uxcrW7zdSsBbQM9sXwqQxVeprcI7IrkBVQdzzfEqbRjVVS8EDsxTClFFRw83bBwcsKmNPc5mOKilyYqKasaOaMTS+6Miu18qnlutJssjlnz7nO1sRlX+MT86uWfjpYREjdjfx6IIPoDjRjDI+PkWMYXFZNUlVvTYUsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgvdQDNjHvv/zsrLcjoCqZz5W4uogTGw4FSj0SzBEkY=;
 b=BiDZx0QhBm+caMA4ybmL8pGn74os8MS2h0l3VgrZg2o63HmovDa5bz551wx4bfCT+Th/hJsNyKE/wPZaM6KY+YjiudhWH4mC9cztibPg1y18F9LTwbX/BOqa7f0yAyjiZK77FKUc0CO9JZdij/iqK6ndBflPFhqCDa85XeR3XISil5bGVwqb6sVaCh1MagiKXpR0wthCnEW8H4dH/mX2FL7cL6TedHASfcIoU0QI5Y633xDGX9dtUCGOvQh3WRsLss7Y2LM/bqaoUXQ2m2JltWeIggvN2JIzwUfdki/ZOhU4gHeesHfJ80vhYNYhQ5h21cU6BoTcr6X6sgV0URDjEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
Date: Tue,  5 May 2026 13:04:53 +0300
Message-Id: <20260505100523.1922388-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: 450bf4aa-a2a4-4339-4d3b-08deaa8dd88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	105wNgbdpicT4f2b89LnMCTcdnd1q3oavkS1xKQO9VaEZzAi2cRP5Q9ftUvmmoJhebuOnPsLvS/m0j/zblucoE1bq+tZGWU3X0u/gqm9nzrUD/GEdtykY45GxR2x+qtk4H6J4BIusB4BgA9esr1z+nwqCdooL1VHCe1uL0nFldcTURUpt3yHXIQ5B9Rj4nqpiP/1xY3GMb8XeBfkg/gBNhqkbNDhFZkBxpQgM1KzIFBhfWyOMqkeHGHGu541mN7z/ZNszkvqgR64o+a1czK782ld8qO4S2qWznt1S6WGKxjgcPZIc51Z7ftQojPvfTlFQyBk1um3M8W6+lmw/bSEd4UPNz12dwkOOmZgenuxMu+6bMZbbNYgOjYRoigo04D2A4yog73uCa7qnmnhd5GEQUMxul5ePtGCBvreldRdF/dvydGWJ73ljQyTVPfA4b35FLjeSZbvIoffeuCDOmz/rbKYa7l3H0sZoO9Y5p9xPpRDxK4UYPUR+z+VyyZEm1YGb0npn1Hd6V/dLQjoPRzL4M6XD0/7xRnai+RQs1JJHZhlVse0eyGpPqSPPZddEKzH5bPQ4lvDIQHdnCp6jt5S2iDJQ5cSvAfoAF4cDak4rq051dOhNsW7Cpi2TEoEC19m3k5JqZLCmhEZ64S9J3CCkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhWbndWR2J6WVpKdnA1cUI5TnpMSEdLOCswbCsxMFZraisySURqVUNKY0tK?=
 =?utf-8?B?T1kzdE1tR2JhcTkxYk4ySzFTQUV4eVpyM2xmQm1adm1VTkt6SklDK1RXSTNl?=
 =?utf-8?B?QUdVeURIZmxCcDRCSitJY05OV2lkbEcyZUVSbzBUTDVzV21jSHdFbEhVdFF0?=
 =?utf-8?B?eGQ0MFQ2dzlUL2tobllPVDZWVjVhOUtyc1dUYWZqcmdHMm1KMEswOVgvcmRM?=
 =?utf-8?B?L3F1TjRCQnlIZmJKNytaMzFYdEVrT1ZZeEVnemNMMzBGY1l5R0RjWGVtenly?=
 =?utf-8?B?VHRyQkVuODZudGV6M2RockdsdUdiRWtvWVNDOTlxa09sbXlIT3l4SXRjMWsv?=
 =?utf-8?B?ZWwrK1dpTUhyZEdsNm1wRWZUTmpBVHI0V00xeDVudDFQK2EyWHlCU1lVZDBK?=
 =?utf-8?B?eG1KanlrY21hWnJDZWZKZE1jOWdHbUZ2c1RlMWZVU0pxeHhzN1Fnblc1TlJl?=
 =?utf-8?B?STlYWVVuLzlITzZ3Vm12UkJSUy9EVzFhUEVzdm81Wjg0YTJVK2RnTUlabTU1?=
 =?utf-8?B?d0I2OUpRMjYxbzRjVFlSdVJFUmEzd1oxaFU0WVhlWTZndzVSbTJqaXNtVXNQ?=
 =?utf-8?B?ckNwL2pDalhLNUhQK1Q4TXpaUG1yUVlZMW5xYjI5bzJDS1ZGeEoraC91WXRK?=
 =?utf-8?B?L3FpbE1UTEhuVEhRckdaelI5cnZCSFRhYXA4Z0VGZmhKV2I1RXNkM2tHUUJY?=
 =?utf-8?B?aG5BVXltRERlRjFKZGJRVEM3R1RSYTdaTC9QMkFSYmlONHNUNGQ0VW83MmFG?=
 =?utf-8?B?d2lBZkpacW5BWW9JR3lwczdrdmFuYTE4Vmp4YTdUZ0tnVnlkcFhDL0U2dHpJ?=
 =?utf-8?B?T2dPdVhCeTlTZEYzNENWL0NwWmt3bjFHOFZxNEtJN0tEaGtpUEIzbmFrVVYw?=
 =?utf-8?B?cFdYR3ZjdFlJUkJDbDJPaHNkcDU0R1dPeDc3cHZHYUUweXM2TG1sUzBqWUtz?=
 =?utf-8?B?d0RWMVRJUWpQK0dQTEw5M3FvbzBVdDBOb0luVDM1eHNOY1RuelIzTGlEN1Y5?=
 =?utf-8?B?WktUbDcvUWtmUDlya2x3OVR5a3RHNUZjY3R1NlRQcEJmQlJtcXNocUZIdVBt?=
 =?utf-8?B?Ty81VXExTnpIWk1aK1NmTm4zSnM2TlJSQk5HeXV2T0FkVldFdE95TWRMaXd0?=
 =?utf-8?B?T1hCZHE3R3ZnM0JLMnVMZWpRLzhkTlN1ZjZiaDVTbzRJTHhUVTVncGQySUNn?=
 =?utf-8?B?eFZuTWZmSVA1ZldINWlDT0ZwNW4rbUdUN1VpS0hzSTMzRzNTejdQL0UwTEFp?=
 =?utf-8?B?T05KMXNoRHZFcmd4SU5PdHB4eW5FVUduMTJQc1FoOEtHdUYwaHZ6MDVNOThu?=
 =?utf-8?B?dWh0T2RZcHpBbG9uU2JCYXlMd1lTL016V0dZT0tGZDlRbGRPUVlwWUkvUWZH?=
 =?utf-8?B?ZTdVQTZaOVYxZG02SUlIM2VHTmhuT3RiRFhLVTFGc0NiSW9nOWdlTnNvcmVO?=
 =?utf-8?B?WWNKSXQrOVZDM0NtQklyaWVoSmFPV2h1NlFhVitxczIxZGVTY3N0eWlOaWpC?=
 =?utf-8?B?a1B6RVMweWp2RWE4RDVFTXFpZDIrYTJtY1ZiMTBFNWUvL2hxQnNBME9iKy9Q?=
 =?utf-8?B?d05pczBXWGZzZGZIdlovSDJuRldoNjdNUTZSb0dRaytJRGw3TzBlZHpGU0lU?=
 =?utf-8?B?aEJDRnFwdnFoMVA4Vi9PTjE2TjZ2OWdRTGZzRWRRVkdpbEwwSTZ2MXg1U09v?=
 =?utf-8?B?ZXRrWnlGQ1RMODViakMwOStTejdsMFVoNGFnWHE3U2FTUmpROCtWZGxjRVIy?=
 =?utf-8?B?UVJmR2pEQXNlOWh0N1psM05zR2xvSjJPT0tHS3NNUmZPVjdRalNnbGErWjJy?=
 =?utf-8?B?ZVJub0FSTjV5STM0T0svZStBTmh6VXdUNmV4UDFvMnpsTTZUSXk2Nk8wY1Zh?=
 =?utf-8?B?OTVkQzB5eEh5MitGWVZnbkgxUGJVSFRFNXhtMzlaTnN2Q2huYThFVFFOWm9P?=
 =?utf-8?B?SW1TNStPNE9JQzhSSjJVcDh0YW80YWE1ajNkd0ZHMUpGSHJBNkV5WkpFbERv?=
 =?utf-8?B?K2FzMEZQUDB1bFlDRkxRVkExSURLVnNnWVZUZ1JXcTJTMjNta0s0NHBqZzZD?=
 =?utf-8?B?c0t6VzRjaUEvQXZqaUkwQUw3VzRCR1JDR2NDUVJjSTRkb0FKYjJuY0VlcE02?=
 =?utf-8?B?Z3lkUlFiYVp5bEdWNGxvUExkY0UxQmtKb2Nkd0Z2aFBKQ0JQKzlYVmcvNVBJ?=
 =?utf-8?B?Y2tMWXVMNDR1ak5lS3g0TlhhOEw2NVNDYUZpT3gxdzhaVEpzQk1QK0FwMnMr?=
 =?utf-8?B?MnBEYUxoeFFjZ0ovM3gyRlg3UDNYWVUvWDZodmMrNEtmTGJScXdtRW5wZGNZ?=
 =?utf-8?B?UlBreXpOdlBaa2FCZnZURDFGWGJab3lGclE1d3ppKzh1TW1MQ2UzZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450bf4aa-a2a4-4339-4d3b-08deaa8dd88b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:33.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7I834rn8G2VHkN2OXvP0Zt86b/FZ12h8ktzk+GjOyLVyl5+rBES8wnBDLiT3tpYQOyM99O4pGAtLBy6qUsqkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083
X-Rspamd-Queue-Id: 5046A4CAD9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7490-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cadence.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid]

The blamed commit functionally changed the error path of
cdns_pcie_host_probe(), now cdns_plat_pcie_probe().

When the old code path executed "goto err_get_sync", the PCIe controller
probe function propagated the pm_runtime_get_sync() error code. The new
code doesn't, and returns 0.

Similarly for the "goto err_init" previously triggered by
cdns_pcie_host_init() errors, and now triggered by
cdns_pcie_host_setup() and cdns_pcie_ep_setup() errors. These are not
propagated and will result in probing success, which is incorrect.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manikandan K Pillai <mpillai@cadence.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>

v7->v8: patch is new, issue was flagged by Sashiko
https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..8b12a46b5601 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	while (phy_count--)
 		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
-	return 0;
+	return ret;
 }
 
 static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
-- 
2.34.1


