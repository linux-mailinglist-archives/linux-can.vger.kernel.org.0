Return-Path: <linux-can+bounces-6475-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGAiAODygWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6475-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:06:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F748D9A43
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D05CA30FD07D
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60126350A3D;
	Tue,  3 Feb 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KQmawtxu";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KQmawtxu"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021073.outbound.protection.outlook.com [40.107.130.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C937350291;
	Tue,  3 Feb 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.73
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123735; cv=fail; b=HFBm5p8x23bACuk4X3uiYGLLY1Yfs6uLuZb3OAGSMKkqI3Kv+E8QJz2VpvCCiLgfGLMfZ+Bc3Qr8AYKHB0CEa0fUNz2tYL+pi0LsbMraJBCEizfmRXR7n+YRXOiDY8B77OETe4+iK9MlYhjjaWm7i/lfcgYaYxY/HjxJVUK6qpk=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123735; c=relaxed/simple;
	bh=FwCeAlL65jRAmNiqr66Ng9q+KFcUiAA1V+QFDlOA0sE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PFsa3P+Qqa+0V6OBXe29AKzvy7gjXQk/dnvDlB337EqEzoIupsMjSsIOIDstZA7k/HdseSCbqLdQFuUzExRO1Zx8ccF5Vyd/jhg/CH7MveiefGZ4tmXrj90bF2H7Jq73pJQfXKHp/69ky1SiQrF7Kz0SWs5xhogOLl6gjWVh7sA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KQmawtxu; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KQmawtxu; arc=fail smtp.client-ip=40.107.130.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=suVaAMBxKfylA6LcXjuLgp3acfSKRT0sYaHGvvNuQXjacz5RAJKWTJqAgBylq+G8cGotmic4irnupJPNy9Av0YmgIyMJdSd3WDmbQxmDw2tQJCpBlN6MmtH0ppCvJlU1hFrB1/dwscfV/OViqN4v9pCVC0EieVaQfjBxrEUOICc4OzDi9DCHse0Uy6eHcjMyBRfPpZUicyMGziU3CtInA3vtP/AmUH84O53vr6zvT7lTj3kzjxc9zVzVqTjwbbBaA7hyN1sCdP/VtUMlXv0Nb/Ve+arYlUKoUXL/0NLK3E1uEWPbN7eu9vmUUy4gMwqQVeTUpvhotGY0cEwKx1GptQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=v3yn9tJjlURU4JSs/9fVYCo/khfGW8bUBqwuB9MrdgbqzWmlPmss5Xs+iLhdUnwQtybPZ6dpaf1kvHRkAYFMr4mzHyQlgUH63WAdtFccZmAaHgHoRlr/2cSlUVhvkS/RAxmuG9Pj5uaGzsgpizHtQ3uanM1hK/xGkUApNtObhlzz+qQawqrMIWYvuDK+p4CN4SN5uf3KmoYm3fJnUJhCE9jMIu0uAtgp39leaOc7LLI3FgF6Z1F3F/M3yPwjOzBOk97/oHLvDYEr8PL2UWYzgmElbAzDHQsnG5KcfW3gO8vdLUiCKypS3acBi7rC2GmNmh1lXFrMqXVvge3/90Cptg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=KQmawtxuQRKnSnoAzGYu5ceHiss0xQMriI8RG2a51tTAE7AUgLfxnYT/DikmxEj2OP5dkV2M4d8fTu2zeZWzOnislee86tOe/sktEXcUr5j7dnXkbPYQd6Sr1iaxugKxoxtbnYFQwwqtxgivU4H+ix8cZ+Rby26Ln1VCGSMCz30=
Received: from AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25)
 by PAXPR04MB9447.eurprd04.prod.outlook.com (2603:10a6:102:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 13:02:06 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::7b) by AM0P190CA0015.outlook.office365.com
 (2603:10a6:208:190::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:02:06 +0000
Received: from emails-9939603-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-175.eu-west-1.compute.internal [10.20.5.175])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1155280569;
	Tue,  3 Feb 2026 13:02:06 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123726; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=n/J9ozpLPwazsM/mmIPYogYintF5EDp945IR7x0cV3624e4rBhAd0G59HVx4/OaupRLup
 1vvQNYHK+23ZCDbjavl4sBko+tvtvlMF5Ffp2IxYXAJ+u1x9UnsZEUolLc0sN0h1CjVAHP7
 zwPCMMuBE9ETcGHZLGlROtVCSxinsps=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123726;
 b=E7P9POhaWdCMpj07bAeczJMLJ5+aI60KNZGqgGK7JtN29Ei/a062JvmgTcHzFqrIbUAgL
 WKbLV8ptOvq5LvQ/9cRQ7SIr57Z8DEGJZh4G8zPZ6EHr3CudaZchyU2eeNp3bFLPY9sawrs
 /4mWQIULSOAGIItqx0XhJmX2iK9vxN4=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bev2uq1rM/KDxi0A9IH+lONEMbbgriVkYevJL0C2mhAvI7J/oz0JV1h9AaCD5v8VJeIyk3i9+W5D5h/vEkCZYARgGzJN16GE+VokTInsxM44r31XsS9yGFWU/0OLZ0yMQgDhn5CIhOKRm6l6dyQuN/NJjtNSlcuIsuRInSp0jERQCaJF1BovOkc9EnhgNwtwMi/q9LesWRMPEcL+z68Ya4NdYQmEq0wiV2UHkGo8XI6a0/sLEvhLcR1+Y4UnBncna0Wm7UU+g4RRNLEaYgiPZ/tUSS/pqFg7vIltldiZhw8mbc5j6G9mpqVxbZbMAXyWkEGmI9RRQAiE6xGP7Pjbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=QWWjxMyvW/lrUSPkk/xqt/AkCQVL8ziYKgg5AblJa7aKEAlesu4LjcOKk4OCZPzrTVqzu9XE8D6h3blzTazPA9cs2ijvZVu2u5gwfyfFSxCgX9X/38CgCHeEjB2bPKGGeECipj0KFLA+3X4JmIl5BYEiawYjUNasE4EAAmV56XfSBKFktOqtlVaiSjujklUFJMJhB3XYFuIjKQ0MFlHnYqusmxnCDXm2Bb+AVF+r20vybd1yinKQjxNRjMGohdVVfJX8S9qBMDmLdYTzJmffvxRdegYx8TGVb3bJJ24yC8FcsIqASpZJkFFuOj7Lo4xHvnJKKO9NZFLX1xUkNaf81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=KQmawtxuQRKnSnoAzGYu5ceHiss0xQMriI8RG2a51tTAE7AUgLfxnYT/DikmxEj2OP5dkV2M4d8fTu2zeZWzOnislee86tOe/sktEXcUr5j7dnXkbPYQd6Sr1iaxugKxoxtbnYFQwwqtxgivU4H+ix8cZ+Rby26Ln1VCGSMCz30=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:53 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:38 +0200
Subject: [PATCH v8 5/7] i2c: omap: switch to new generic helper for getting
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-5-024ea405863e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|AMS1EPF00000041:EE_|PAXPR04MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e03c469-cc19-42ac-47d3-08de63246eea
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bEpEZkhXN3Zxeks4VTVYVkNiYlZkR0F4SHZzSDZaUXp6QVFzRTRyUWJRa3Ix?=
 =?utf-8?B?ckExMUFYYzFjNG9EdWlQSEdsZ0YyUGZNaUlrNFQxL3dSVzJyMjhCa2NUVFFx?=
 =?utf-8?B?dStrblArZW5aVW5iRWNTZytrOERWcmZ2bHZWL3ZZTHNYU1BreXVGVHYrTXdZ?=
 =?utf-8?B?SDdyRmhGbFE4Y1g5SEVENzJaTnZkM3cvQ2ZNS1FEdXpuTFF5aFl3Q3pVSDlX?=
 =?utf-8?B?YkRQM3hNNEd4a0ltYXVjTWdPdHEzN3c5b3djaU4rdWoyT2MvWXdtZm0xUlZ3?=
 =?utf-8?B?NzdnTTFWS29YcTNoZ3BTK0g4NWFGYnF6dVJQdy8vU2o2NFViMXRiNWJuTlU5?=
 =?utf-8?B?eVIvSDNFaTNCTm94YVJQT1VWSC9RMng3K2syVitvOTlTQWlLQVN3bXpxSDU0?=
 =?utf-8?B?ZVVXVFJQSWJyTVhFajljV3lxQ0t0NjFsOE03Rm0rYlNQdHdRRmR1c0NNb2dN?=
 =?utf-8?B?MzlQenVMUldlVllBNFVnekluMi9ST0grazZKaW0xa2RYcTFlRU5nVlBhUndN?=
 =?utf-8?B?NkJWMDB1ajV4amtWd3IwaVRTR0dMeThaYlRKcFZVdXpzeGsrS09nVkIwd29Y?=
 =?utf-8?B?eUpiU2JucU9RK1N4cVpBVDEzNStrUS9IT3orZDIyenZNZ1pzYjZZaUtPZHB1?=
 =?utf-8?B?YWNCZ3UwRncxV0dYVjhJREp0V0YyOEJNVjFJL3JyZEo3VGNXVG1wREtkNjNs?=
 =?utf-8?B?MDMxTlVYSGhGdlBkV044dmxFRkFSbDRDZ0tLZVM4K2IvZzRHVEthdWVobHZ6?=
 =?utf-8?B?OXlXeEtqNWlCMU5tR2lGbHVzWVBlRXk0cC91OGVwV09lYXMrME1UdStYM3hC?=
 =?utf-8?B?RloyeGNqTzNnU3JRZ1h0SnRCZEpidnhFejY5TVZ6Q0RFWnphU1BuSC9aYldz?=
 =?utf-8?B?c3YyRjh6N3c2RUxkS2RLSWh2SjFrRTRQUlkxNDlYY05icmdGNXFhd2gyV3RL?=
 =?utf-8?B?TTc5V3NSVFVDQ0s2RXRMaElZeXFtVG11WUZ2aENxdDRhbkxWRE5vWXVpV1Jw?=
 =?utf-8?B?dCtyYnloWXEvRzRuNE9xeU1mVXBsMlZ5eU13Ni9OMHIxcTdRMnlXbDJmNHQy?=
 =?utf-8?B?RU9WaFk5d0lVNUNKNGFMQlowZG5NMVpRMnU4Mkh1ZjBaUmtvSlQzSHJRNUZL?=
 =?utf-8?B?S3lBcGJTUlVsTDQ5QnkxNWtEZHdqVjNzbU9uT2QyeW1JL3FuWmFILzZBVS80?=
 =?utf-8?B?OFI5U0RvcGtDbXZOaEVPcytVcWtiN3BhVkhPb2MzbFFnZitxOGtOZDR3VTNB?=
 =?utf-8?B?SGN1bzlLTTdCZXBZRnBwbFBDTmNZZks0UTlxbGljOHJTcHhFUDU0a0FQWVdH?=
 =?utf-8?B?bmVzY3NLTGhCTkY4TS93bnVLMzdhaER6Z3NMNGdVeWZmaGcvSjdoU1Z1MHht?=
 =?utf-8?B?NVF1bXdpTVJaTlRCNC9JUGYxbDgzNmEwTXZSTmpYR2VocktoSFNkM2RXWmtR?=
 =?utf-8?B?eXAxS0Q4TFByRlJZMXFDMTU1RzBVRUF2QnRYMThDS0d2TzI3Mll4WmM3N0V0?=
 =?utf-8?B?aWdQVVJkcWllUWtpWFY3M2tUWkthczF6VGdvRFlhb1VBWm94L3lKZGVUV2lT?=
 =?utf-8?B?eWhydklyeEJ0SExKWEhVNVZnbm9aelhtSElPSCtzWHJMNzkxUUZoYXgrU3hq?=
 =?utf-8?B?VWZva1JEMnF2cGltN0kyRGJzTXdaVTJkWHF6VWR6enlnV1ZEeStWbFVtVDVO?=
 =?utf-8?B?Rnk4Z0l0THhqR2ZoWEZNQ1YzQ01RNEx3Y0YwSnhpOVBMR2pKMkhhY0h5MEE0?=
 =?utf-8?B?eXNKeU82ODAydGNqYkd1Mmk5RnRhSms2R0VmdFdLelkvUUdsZXcvQ1Z1di9V?=
 =?utf-8?B?SDdyajJETmV4MjRwVlpmWXl0STdNRW1ScTE0U3psVDM1ZWExNnVnZzJ4Mmlm?=
 =?utf-8?B?aU9jNmd4M09zVzRzOW9NaFZsdEJDUEE0bFVLSHV6WUhXWXlXQ01TdjAxa3kw?=
 =?utf-8?B?cEFHTUsxSWU1dUVJeklQNXM5UTl5b0dKbXJVdzc0OGR2R3FTckFmdVA5azEy?=
 =?utf-8?B?aTZ1VjJ1eVljK0h0cWloWFc4Rys0QjF1bitnQS9JazVVK1A5ZThmaDZ3c3c3?=
 =?utf-8?B?NUkvUmtEQ3ByZzhzU0cwbWdaSEN5cERKdVBXd0I1aXFMMGZydVVXdTdFUkZP?=
 =?utf-8?B?eTMwWjRUbWw0cmdTYVltYmVmWlR6azZSRlN6L1JzdEhZdlN1QkRyd0lVMmxT?=
 =?utf-8?Q?Dkq6IroBcIvH4LeW4GFAW7U4BFlwsXGy1UOfLE15y2vB?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d41246a5e4fe408db59db2516ed59022:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	471a64d5-4c65-4286-5044-08de632466df
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|14060799003|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFNmV0hYTnQyV2hIbS8rVnJFNG5mdGwzUytQSlRhQmpPWkF2aTFBT0NRMFlC?=
 =?utf-8?B?cnhQMWkvT24xSFphVlV4UjdpSzcycmNRWVhLaklvWCtOcSsxU2g3dDRnOTRz?=
 =?utf-8?B?UHRycmVocllBVFVpclJ2c3VLQzNDRnB0QUIwa2hVNExXd05jT2t2L1M0Vk0x?=
 =?utf-8?B?ZG5leHJEZmh2Tnc5UW5QMkxzS2hab0tpSWpxMzZaVlgvYi9ENCt3SFpnOVVh?=
 =?utf-8?B?emJQWHdIdHpPdlZjMlIrWXpLbXR4WUd3V24zWHV1YXFyaVh1WlV3ZWJESHM3?=
 =?utf-8?B?dWs0bUJPZjRucmlPWE1XcVJyMnBlWklMWEFtK2ZvWmIrbWxQQWFiaVRsc0Ra?=
 =?utf-8?B?eUFwZkRvOE1pWE5uNmU4MjVEUndEa2VYZFpKUzlYM2lwV3pjMGV3b014alFt?=
 =?utf-8?B?eEFVbGV1a1FjdVJkbHg2VGNrTWtlVDZJRmNEdE9BWmkxc3B0N3VWRVZlZ096?=
 =?utf-8?B?UWJwYThxeFBaTlVpdlBJQWtpaGZrbW9yL1dnalhXRU4vQW83MTVGVWdwZlFv?=
 =?utf-8?B?Y2Ezc2dhYkUvanMwcWY1Rks2TXdCVFpucldHeS8zVU9GV0hVYmlyeHZWY0JJ?=
 =?utf-8?B?V2ZicmtPbE1kUVZqczJROE95YUFyL2VVVnV3NmJiVFcyZ0dBTVpWdW1ucWo0?=
 =?utf-8?B?WnBKR1BnbVNQenplZlpXMmNxVHlibjRGVGVacmZKNFNKczhWUXI1MElPUWpt?=
 =?utf-8?B?MlhlUVpNNUZXdW8wTGJ0bnhZTm1jMXluYWRFaVBkM3VZTmd2N3E2WGRCVWxX?=
 =?utf-8?B?ZTl6RHBkUDZLQkFwRnQyazBMMGs2WW5zazNOWTBZcXQ0NEZpdFNmdmNnTm96?=
 =?utf-8?B?YWVCQ1phWTAvMmh1QUZhZEJyL3FQYWhocC9xSU5haHFkNW0yektNWGdIYjZ4?=
 =?utf-8?B?MGVMazZkS3lKVW5wVk4rbmx4Nmx2N3BOZ1M3MW1YNUxUVG90OUpaV05RdHIv?=
 =?utf-8?B?RnN2ZjFNZ3luaHBWenJVU0lDVjhlU0w2U29EeXZOSURQOVZhSnAzSVhEN1pB?=
 =?utf-8?B?OW4yeS9uUExsS1g4b2hZSXRudzlzSjlMRUxCVGhwUkZ2dzBhejdqenpKWVRz?=
 =?utf-8?B?eU5UK1NvZ3VyaXR1RjR5ZTVzZXN6dG9ab1NJY0NUa2FRZ1VkMmhVZ09ZczVN?=
 =?utf-8?B?d2RweWtxUzNDUUVvMXRvclAxTkZxSWNOLy9kN3A0aTBTelZPQmllZTQ4T1dk?=
 =?utf-8?B?R1Fjekx4N3VlSlU3YUZ1d2F5WnBhNUV2bXBpaTNlRFFXYitPWVBuQlV5R2Qx?=
 =?utf-8?B?UUlmV21oVTRZYjMySXg1MWtvQXBDZDZ3eFZVdlBiSGVPckl3OGh3c3Rmekts?=
 =?utf-8?B?NkJzcXdyMzJmS1pzd2lpYTRVeW1PMU45VjhNWk11OWdGK3MzanNFZ3RIdDZI?=
 =?utf-8?B?OXlHWTJ6Qm8wWkVyNElGdWJIZXZUQUVRMUVIYlZrSjdzSzV2STB6d1RYbW8y?=
 =?utf-8?B?aGY3allOenVXTXgyOUVQR1lDMjlzWm5sNk1ORFV4ckxFYWhMekUzM3oxUzVS?=
 =?utf-8?B?WFp3YUtxTy9PZGttVFhoTjByYS9udGJlSFZSeDY3TmhtTHBJektoK0tsYzMz?=
 =?utf-8?B?OHFkYWx1YXJPdEd4cThacUR4WVRiZWVUQ3RkM3pRbi9sdGZDUXdnSWlHc0l1?=
 =?utf-8?B?aHFTZ0VrRFRsZnlPK0tuQ0ZBVkpDczJQOGNCNW95SWdpdEdwQ1BNTGk0a1Ev?=
 =?utf-8?B?QlkyRlFsdmJDd0tFNEtqTzdobk15MnU4a1ZUTC92aDN1amZkRk5MWHhUaXVC?=
 =?utf-8?B?NUR5ZXM0ZjdsK3Q5bnJMd1FON1EySGxsTldOU0NWMFZ3RXZNaHRsTTNFUU52?=
 =?utf-8?B?b0hIS2xOeHVqM3hKRGdrQUkzRE5GM2RxZ1JlaHN0YmVremlFSkZBdTZrZHk1?=
 =?utf-8?B?QzkvZnRGL1JxdXEybGovOVRSSE5mb0dRckMxbElBWGRlYzRieDRLVGw0a3VN?=
 =?utf-8?B?NldoM2RJTGlyS0ZMVSsyMWFmcjFLMy9KZEg2YkZVZCtpckF0dktJOGhReXRa?=
 =?utf-8?B?M1cxM3ltRHc2TmIwOTg4dW9xRTdhU0drNTBSdFAxTWkyNVRKbEI4MFhaQXlX?=
 =?utf-8?B?YlBJTTVyc1hFdHQrT0oyQXdXdEx2R3JVYXlqZ09kem45RFp4R0xkSkh1ZDlv?=
 =?utf-8?B?VFhNNzNYS1M3eTdoME5kQ045Szg0RlNNYnRxQ091QTcyRTVrb0h2WGZkN2tM?=
 =?utf-8?B?ZjQ5S3oyRkl2aWJHTVRVV2tFa3NidW1uVHVYMFRzVWhSTkgrb2wwbjZ6MU1Q?=
 =?utf-8?Q?ty3kPNRXRihB4D0OOEP0KJReZsIA17+IKhnstQHWeE=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(14060799003)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	od7eCd7ZD+WcH8BIxq8Pybzl+eGDoh4F3911k9PRfM/ktzJdMYa6vYy3EbuAoObPHOWey/iesPE9oMJaxSV7hezU+d7XMrYIlRHpa5vabd/n6b4LR0fNbL7iPuyQtl1UXE9mt5i0ePVbVxSSVKJBCHOCxQdXLEwAjrmReT/JaNkxhJB+q5VAATI6L3Sx5XyuNyVmFJ0zxwbOxl2z7Sp4C91C3bGlX0FPGMHi4KWSUqhiNsUjTVnDJkEqP6lsfhE34jrICYxyLghqokf5JhMleZNfywrWTnt+9eoJW7gpdFqFUhcPSlSE5cwPpymuf7AM6RKnBPn3W/8qvgg+eMvLAoqol+2kFtf6Lc5hz3TTld7fWX9nz1uMrm166LyhOAEvfU2ik6Y0Tkd3diH7wwoee7/s8IBi0BnbxAz4zFGVNoVM/MsqW6U7putH1QDwvReH
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:02:06.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e03c469-cc19-42ac-47d3-08de63246eea
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9447
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6475-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,kemnade.info:email,solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9F748D9A43
X-Rspamd-Action: no action

Multiplexer subsystem has added generic helper functions for getting an
already selected mux-state object.

Replace existing logic in probe with the equivalent helper function.

There is a functional difference in that the mux is now automatically
deselected on release, replacing the explicit mux_state_deselect call.

This change is only compile-tested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/i2c/busses/i2c-omap.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d9f590f0c384..f02d294db42a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1453,27 +1453,16 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
-	if (of_property_present(node, "mux-states")) {
-		struct mux_state *mux_state;
-
-		mux_state = devm_mux_state_get(&pdev->dev, NULL);
-		if (IS_ERR(mux_state)) {
-			r = PTR_ERR(mux_state);
-			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
-		omap->mux_state = mux_state;
-		r = mux_state_select(omap->mux_state);
-		if (r) {
-			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
+	omap->mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(omap->mux_state)) {
+		r = PTR_ERR(omap->mux_state);
+		goto err_put_pm;
 	}
 
 	/* reset ASAP, clearing any IRQs */
 	r = omap_i2c_init(omap);
 	if (r)
-		goto err_mux_state_deselect;
+		goto err_put_pm;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,9 +1504,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-err_mux_state_deselect:
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
 err_put_pm:
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:

-- 
2.43.0



