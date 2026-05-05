Return-Path: <linux-can+bounces-7495-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI+nN13D+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7495-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D64CAC48
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AF6304F2EF
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EE3A7F61;
	Tue,  5 May 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bjIj0AZ1"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC21334C39;
	Tue,  5 May 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975557; cv=fail; b=hNA8cM7jQ9LwXmInUba0DqeqQEJ/rRODOVfdXxPD5PAwlCpkdtwYsZP3HqG3Q4DzlBHvc9aNOBPB+rstOSP+nm2BCimQwwWW8u/tDcXqhy9bpVc0dRZ+MPTuiFJwYEvP0qkTW1NnCbN7R9BwEUGtK5kPVQweESSBYRdrcI06g5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975557; c=relaxed/simple;
	bh=VJRQ0+E4a1KuHZIQNsvfcHNkKTos9dV1dlgraMSUjTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKkQ4wCjJ4T/9i+6hPJLMY1giPHRdJYOfL/CC/DXxxb9ahD2Peq1gTWjSnnZ8sUOyrKyI9S+8FRzMxlvnMGAgjyyARFCGLpd4pTh68qUeSf+uV0QvNW95v11wqybPUsay5dATfooxOxvOFY7K0jTk6WQS0lcPIzSGAWf40ICf/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bjIj0AZ1; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLZdleZDfDlpj4IN4vXovmDzu0LvKGmBaR+VLoURCx0AiLwU3OL/o/Q6/BqogYPxTCz0xRbOkHvw4J5cXVXsJrBk4dzOMUVoJhs7uCj3vmiS9yuF0Xwc9MIB/qjMSCCQ4beXQkKjejvur4d/31tYfYTamYHBjHgmzxw5LUPnxOHuvUO27gro8XN1LXTdfnE8vstrVlL4Y1jMGHqJ4zfAxUDX7H+s1ke0BNqnWcNenuiyqrCqGpsfxPoggNJCQh8oSApmyDYmjuM/YcTToeUaDWai7UyfW+TwlnSkODOxAO7HwqQkwyRRu8nFro4IQmTOlf3NTbfpfmVfLan04a8nXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUfxaRDDzj6zRamOfEYgjgadfkyv/1InW6h07m7tSwQ=;
 b=MePegVF6EirLQ6wLEo7xQai5okQWgIoN53QKRkY+oJor5AoRbhoQvkNaoEPYvhC97OgQGHxUQgMS4uAgGCIcDc0MI4jnh28ZshYjQ2fbJfeKuUxW0GCK/i441bq4Lij9ZV4AWz57ipZgTwuP4mreD5bjPOkV+Q2KVUWs5m75/52jU/jpc1C9D9wU4wIcRvtGpnHHAFqbh/H4pt5UxnNsMKrScGaq89AaiSAT3En9yxo7eDsz12uI7OVPZjNJUVtEHvZT5hIJEwkmb8Xvod89GyPxn36h/JldAJZEQnO/N6jTo9cTcPBONutIRWKJcpaVZUM6wVLuefhxFnMk7kZAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUfxaRDDzj6zRamOfEYgjgadfkyv/1InW6h07m7tSwQ=;
 b=bjIj0AZ13M1U76KdCW4okvgkH9bRfDaHFY4ZPeUkrE4yQderze1SP7H5kegWm4ZvnwA1915fAp3KsXHg99xWidlKMevIWsdwawLVLPyT8zONi1jaigNjU6xyR3auI9deGW+byNCu0QGxAwnT7+JsksoRf1dwffr85MxQYGC+WYQN9bO24ELUUS9eGvRT5dztucIBA0v/qsiam7kJ3xW6e7HAb4O+d8c8CHkqvJpn6HvA4PBJLWXiW+xTacETSKEKpNm/UVYg1cnlPD4uh1r2oQ0IX6ogR+4blFCQBuGvueGHVVwEqbv1AeSs82Sdxr4HHYxQJkkjOGGna+wxMA89Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:47 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:46 +0000
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 phy-next 06/31] phy: add <linux/pm_runtime.h> where missing
Date: Tue,  5 May 2026 13:04:58 +0300
Message-Id: <20260505100523.1922388-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: d14e3274-e83c-475a-6d87-08deaa8de06f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 GWjyNSI/AtoJfmp9q4gEFiKYCettvCYR9gRbPVubBa/YXsSfZ64/x0cz5aKBDn4Jm6yxy62qN7uq8OBuP3d62uA0efw/fGImMNlDzK6L+FYtsDmzNbZZ0KMueQuoyOLzLYOpHeJvU82knnxq0bpn/ND4Tr2HVPZlEnmdZW/loFlPwUGhnyznboVS3w+e2goHxGpEDn6iLNc8v9LljeFU46cC8hihCfzxise0nLRJME74RvsUAgjFPd2Fh8Ws8bPSGRIzHKMumojLSzTHaxOFmPGwt3C511Amk6wpx473Oq8VH/POl4I7Ry1313dT+mNFTbc1thhBq2ELOyGmoecjAtdIk5zQ1e1bEsNd7O+WRzvYyiD1maxqDp2AN4uoxDzx8YbXLletl2ZeUv1Vbjz86CPq+TKYiKs0JddIMC3TZR/UtAx/w+OOvg6WuO5zYftUIPRmYZIMhQ/JC10PokY6wSiF0bmeNZn6ihdCrNYRDQRFRteGHQ/ftaHsgCmEDEdjUCR3AxR/l525l6C3VzJQCfMeTlEka3+mxnzZl2GICb+dLcVbyeGnYmge/q2JUuIeq0bXWtPSe2YzBdnjVwU/nQ2ugiqEaVmJM/fXdfBUdauw/nPSdwUT4ZU2BB1vZvEICQ0js0CMhaGfi08Hj+873g==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZHMyR1NHd3IxNi9SWk9CRFhZeTZIRGs5OThKcmV3TmRnc0wrL1ozYk50cjRM?=
 =?utf-8?B?WlVuT0JPd0xxaEVnZzFpN09tcUJMQXc0bUQ0WENuTk5ZclJ2R1FGci9hclVV?=
 =?utf-8?B?Wi9JSzU2YVhRZFdxeURQTDBvVzdNdUNObDlobm82elBZZ2cxUmt3dGVuZWRU?=
 =?utf-8?B?UThINXVqaG0vYjg1cnZhZkhRR1E0cFRIeWR1Z1diYU9zbzNSL2t1NVZXN21k?=
 =?utf-8?B?QkV0UU85MlBKZCtjUnVub093bytuVDdPNEVCeGFBWFhlc3FwWU1YcG0xakk4?=
 =?utf-8?B?TlNkcXdhRmRGM1RGcm54RFJxTGRyWTU4MTF3ZU5GQkdaKzVmZ1I2ZHQ4UGtB?=
 =?utf-8?B?VVZ3c2VlK3diOFlrNU44eFArL3BqZ3VaeFdFS25lMGVQREd4ak9LdW50cXNH?=
 =?utf-8?B?dWFDTzVJZ0tCNzYxcW11dU9TS3dqdWNxNzRJS0tVcnZMb25hdkhwaTMrd1Z5?=
 =?utf-8?B?RWUzV1hZOG9wcHVZTXN0eFVIQzY3azlUVDh3RlJHRDdkNzJWMEZmblJKWHdJ?=
 =?utf-8?B?bUZSUXV6KzYzTUZKSEE1QkpUWTBEUFFjS3hYbkZaTDlzRXlxdHExVE1QUVpt?=
 =?utf-8?B?WFd0YmdsVURnaUhpWm9md3JvRlpuU1JWeUVhenV5ejAyVVlCN0hWV0NqR0FV?=
 =?utf-8?B?Z1d1Z3FNVXQ3TkFOUW9ZWk1wQ3BwYTFlay9CWDlaTE5nT3NZOUpIWklhWUZu?=
 =?utf-8?B?M00yRlFRNU1NWVgzUjZPdUpFTXIrQlZwRFhHWFRha3haenNhL2s5am95cjdG?=
 =?utf-8?B?U1plKy9qVkpiTFNjb0E5cWhDQXBta1phbUtYSjU0enp3VSswb0xJQkRkY3lr?=
 =?utf-8?B?OVR3enIxZ1JOQk5HeGN6MHBsc3RYcVNsOS81UGxFM3FzZWhJQkFPV1VpNWNu?=
 =?utf-8?B?Y1pES0k2NnpnNVEya3djdkJLRVpMRTRHRS9DZ2ZSVGVwKy81dUd4WFI0UlRY?=
 =?utf-8?B?TFZrdVZhbElXU3hvd0lSeTQybWIyZUt0TEJFb2xtZnNsYjVvbE1vWCtNMFRU?=
 =?utf-8?B?N01vdnByMDJIN1ZZMzZRcG5mMS9ZTXJxMkVYeklidVlaSDNXL1BGenZIOGwx?=
 =?utf-8?B?ZVBNSGdRYlZhNnZiZnJoSitwcDk3bzk3WkZWa2djeWk3MzgwUUJja2NjUTIv?=
 =?utf-8?B?cGtScFhFK1RZZnJsWGZLWG5FWnpXWE9nYXptc3RtdU5mK05vYkpsNzE1cTln?=
 =?utf-8?B?ZDhDUnRYS3l0Q3FOaFM3bENDenJUa3JnVjhlZUxzbytkL003aTcxMi8yL05D?=
 =?utf-8?B?QUlNUFlKKzlhK3pVMFBORmRYYjFTeGpiY3pUbXllNnlESlBsYXFzeFhCWkRU?=
 =?utf-8?B?NmZ2bittbUI1NkxPU0t5TXFTUDlSQ3R4Uytzdlg4QUwyVHFBdlpVQ1ZNZkpj?=
 =?utf-8?B?NmtkZkV5S3hXdmlTa0J6enhZNHltelc5OHR1bzFXNEsvaGphUWJUbFlxNUx1?=
 =?utf-8?B?TVFMR1R3OGhpeGhlYXduTFNpWGFWMStpZmQrcUlKL3NqdFA5L2RoZWhjU09G?=
 =?utf-8?B?L2MxbThJdFBkRU5oM1JIN2ZzZFdWT2hkRWZxd1J4WXUzaVF3OE1pTmpqcnFX?=
 =?utf-8?B?ZEVvWmlSUHd3MzZNSDN0VTM2QlpqWTNwYk4wQTFKQm1TOWsxY1pXTWNDU0pB?=
 =?utf-8?B?WmVhRVkwNVdBUGd0R0NJaCsxOHJqdnpvdE5zelcwU3F1cDV6U0xGNWcvbDlC?=
 =?utf-8?B?ZFVLOG1qKzU1cThlRGZpazVLWHpxa2lEcFlYSCs2d0ROWGVmaTNHYU9JaEVu?=
 =?utf-8?B?UE5NUlFOR0ZyamZBaGdrR250d3JIMDVTSlJ2OTBnejA5Ym04Zy9KMElHUVBS?=
 =?utf-8?B?azNHSXZIaS9xdHRnQ1p6WldkcGl3ZThmSEJNenYrYmVKYjJaaStqcGU5cFRU?=
 =?utf-8?B?MndQakRuNzdUSFk0UzQ0TjZsa1pZUVpUM2Z5d1VuempqNWVWdWY5b1REQUl6?=
 =?utf-8?B?Q3BEb000czR5bzB0Zi9MN0piclBHTy9HcURGaGFCQm1Ib2FmNG1VVjdMUnBG?=
 =?utf-8?B?QjNaZWxPamZQaVZtdTR6T1RMMmI2TVZuOTUvZ29VMTd3WHdTVGJ5VnIzYVdy?=
 =?utf-8?B?V3VQVTNDSjlBeVlnRmZiWkZ0SkhHRDJPbG83Vkl5L1M3d2Q0Vms1SC90S0Jn?=
 =?utf-8?B?aFQrK0UxQlBqVEM2ZE93WUlsODI0UGxLaHJLcU5MWEgxWHhpQU1rTXpTRFlW?=
 =?utf-8?B?blNVbno2U05mWG85b25xOXZOTmViY25COHFDN2d5U2l1cDl5TTFoeVcrcDFQ?=
 =?utf-8?B?ODA4MXc1eHA4dnpxYXpCUTVjQVhQUUlRTis4bHcvcElaTFB2bjlKOC9zQ1VJ?=
 =?utf-8?B?S2JPS05WY2Ztbm80TnkrL2dNZ051ZEcxbm9NaTMwNU1ja1VxZGYvZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14e3274-e83c-475a-6d87-08deaa8de06f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:46.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz8NoFO8KX/2GxsGq2dg1BYB+j7qUNgjNsXz1o6Pi3lyuLSBcwSZJxu7B9RzjLokdX7fzA1edI1MyHeM3xcFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 7F4D64CAC48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7495-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,linaro.org:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:email]

It appears that a number of PHY provider drivers call runtime PM
operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v7->v8:
- stop listing the PHY drivers which need to be changed. The list
  was incomplete; not listing 12 drivers. Flagged by Sashiko:
  https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
v2->v7: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.34.1


