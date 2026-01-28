Return-Path: <linux-can+bounces-6340-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK/eDushemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6340-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED9A3214
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 773D1306F59A
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9E2882CD;
	Wed, 28 Jan 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DNYC+3py";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DNYC+3py"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020140.outbound.protection.outlook.com [52.101.69.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36342DA756;
	Wed, 28 Jan 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.140
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611599; cv=fail; b=DpFiEgs6cEWVOoGM+yp0ZCK5R8FFHP7PYMEoEphDwwLh1sAbR6RdiA2Jebpne6HS9qBPhGzqsXd8rZ3lV9ueulWr/x0YudRq1HN85DheqyXgZdNoovRx6uESxmZRdSQJZcGaACGRe/F6rWKqPFnPswJPp1E/cQuQBuZyqfbAmf4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611599; c=relaxed/simple;
	bh=rclNXEH59KvqAPAygrGmVMKu0fhftoxz3CRsimq9TS4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Y3ydBFlvYAzEwSiK/PddCXw+7Su24suMLAaRtrRk4XXDXS4RcZoybpFjNqmTLXoqG8GL4vqmkjpqaGhB3WfTZDR5R8BA9jCPUaMZiv7DdTbXbe7IngJ5SkrC37lfkXyo5cdp/Bq8VDHwQWL5Rqj6Gqz5LAJaXorYVlHuXgUL7+E=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DNYC+3py; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DNYC+3py; arc=fail smtp.client-ip=52.101.69.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jhAcql13cPBh+biv14y0cgIMOIqG5D9pP4sV+ciZCIZBi5uvaXqhbg2M3BS9pXa2Q5vcEQQG/0RiIiVTU8qwiuAjMHnF4zYCoPpxex5cpy4hj9sZy7g66ZNLvJcu+QHznknMGRG+JXfqMtipVxCHIsFpparTNBYzx3RKe873ub1nSNtg7KkI60BECH1yJmgVj3E50b0XpdxGftvhAbfXYczxPbRryqgJ1myuEZurJ0dBxqAEOGk+rsvq9uGl/gpbQmC1jdiHNKH3xWTAOJZ84LxDTj1cpbleBPkmXJ0Mlu3DJI1CCjK/UF3ZMzsBDxP4ECNL4/dageHP9wxqs1jAOQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1+yj/Ne5UI603UJTnKIse3xKBfgoeEdzntfRIwQLQc=;
 b=Fj+DBLIwYlDznCSxsOZB62VHDSyH3upMOLTH1xXDivzZ8RZ3/GjZ5Iz1WAaV1N7vbnZ+sD66h8kMt1xNiAtVFufupgVSSarzSgyw7KymA/yCjTwBiTvhazjfOb6fy0D891aHXOOnYeamfKQCbyHCPrJmMJhxDl8qM4yrRC58Sj3dxsgD/Ak9Ig3ON0B3jHlPMomk7aZOMsyUNruUa1sXowJbeJyHjufUR/Ym73dsvkTsn5nYomui6FjNmp8buPDK0GjBDJgYTY6ilv63BRLCVWkiT+Pq4II9U2g+nEbQBmjvKgP+hbN3+wigkkTvrSa9Pet0eDZp0k8mtE8eB6Trrw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1+yj/Ne5UI603UJTnKIse3xKBfgoeEdzntfRIwQLQc=;
 b=DNYC+3pyb4Kch/UbNvHWId94KoMaq6jjb5kjx5jxkkBj5+ma48lU1L66HzXqSMmzIWBbf1AYb/R5eJb71aFXc1Gha+/aT7V/XnocqmcMU3JqEk3aeN9VOd/JaDLSDFgGTaDeESHT03/qTvVIqkQa0u+oT2Q9ieE4Sn7ooFQr4co=
Received: from DB9PR02CA0025.eurprd02.prod.outlook.com (2603:10a6:10:1d9::30)
 by AS1PR04MB9288.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:32 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::12) by DB9PR02CA0025.outlook.office365.com
 (2603:10a6:10:1d9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:32 +0000
Received: from emails-2547891-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-51.eu-west-1.compute.internal [10.20.6.51])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id EC3C5806F1;
	Wed, 28 Jan 2026 14:46:31 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611591; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=+1+yj/Ne5UI603UJTnKIse3xKBfgoeEdzntfRIwQLQc=;
 b=oO30bIUkme5wzYGwnxTwGLXK7Blcs8UCuQSr0EwV7NDItzPNEGePEpNwMFcUNHIQq3T51
 XKfvpisUnkZqOHEyuzU+VosaAVaj8TVb6APNYrULnFJsWskth+DJjtPYXWcMKLzJZ2zG8gg
 9sUj10qHYfbnln81khB/ninGxrswQAc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611591;
 b=XhrtxTHDtf9x+ihCSVXB/28Mf9MpD7gS9IUYv3j35WTib4zBevg3PQJhPpxc41qz+KaC7
 brqD85MEM6olJ/584RHQEvd8gA67CpnuMw2k1CEsMkxsZdYUjUGJOog7h4ajDnbhuuIorxW
 vzRim3vdxz9phbVRlGIThw0fGgs6/Qs=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9+J+eit0XdBcpH7ynOkZF0HQYx7Rqyni7OBDL934ZdF9cPIIf/yw8cMBlWvdUAz64jY8F5U0zZXjrafqKTNSETyVYRvKYvPS/26hgbgKwhOzvyWXfCW4pJTD6+MaBLODoex3nA8RERfeIYB0PFznKb3S+SAoHJDnltaSjWw/sY74lUHA0O7CibMJhQu/tuBrv8TifxJsEgcVEfVTlS8klMjxGn6zyDofePSRkDWK+0crbMJHaxy+K8u7vqC6zC8Ct97KnlBZKm9Os1Cm2d6c2l+EomIV57Pk0+GO6LoLmqRRjjowG0DC2PKdxNX/rkmGzfHT66RjHHddsGjHQYE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1+yj/Ne5UI603UJTnKIse3xKBfgoeEdzntfRIwQLQc=;
 b=dIhht5mLzHOv+eUDpWhZo8It+AC9/79plxqUEBAnxBF5RQgqMAgOB03HWhMLL7djxlQMuORL1dcRZ+kX8auONYFj5NXGnM4zlu5p6C74bzdpW1e7Aza2ulBzx00fHOvqaw9WjiCddCp1o9ZAPS83D6H0XI2uR46tbkX5HSaRqRRHfAuQGxubiYs08ohBWs0yZ47CdXSK4+pvcWWAZedHCsPJv3TQ3Cq4e9BsfXfGe+4gqRVc1FH3DQnKVMKsopj/GNptj4wmUUwh7Ge71zF1kU6lHvvBesd2odZ/MIR+pAbxNvDJ6IZ9HFV0MVXWl1cI+w0ZY2jSFEBfi3HF86SdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1+yj/Ne5UI603UJTnKIse3xKBfgoeEdzntfRIwQLQc=;
 b=DNYC+3pyb4Kch/UbNvHWId94KoMaq6jjb5kjx5jxkkBj5+ma48lU1L66HzXqSMmzIWBbf1AYb/R5eJb71aFXc1Gha+/aT7V/XnocqmcMU3JqEk3aeN9VOd/JaDLSDFgGTaDeESHT03/qTvVIqkQa0u+oT2Q9ieE4Sn7ooFQr4co=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:20 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:17 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v7 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Wed, 28 Jan 2026 16:46:08 +0200
Message-Id: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAhemkC/23PQW7DIBCF4atErEvFDGEYd9V7VFlgwA1SY0fQW
 Ekj3704UlXH8vIhfb+Guygxp1jE2+4uchxTSUNfh33ZCX90/WeUKdQtUKEBQJb5R5aQBnm6XKX
 z3oC2HRCwqOKcY5euj9rHoe5jKt9Dvj3iI8yv250RpJIQQ9TAAUh172X4SkHmS//qh5OYWyP+e
 1Tw7LH61reGoWUOwW55vfCgnr2u3jtCDq2hQGrL7/88KVCr+/fVN8GRInAdO7/lzcLDypvqtdc
 2Mlsk1lueFh5X/6fZs3O6MWgb5LWfpukXmnG8MuoBAAA=
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
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI1PR04MB10028:EE_|DB1PEPF000509F5:EE_|AS1PR04MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8f1041-83d9-431f-3aea-08de5e7c0712
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UjZIRzEvNkRvTTRKeEc0SlVVK3BtRkx1U2VNQXB5Und2NkJPcmpnamgyQlF2?=
 =?utf-8?B?empSaHllbWVDWnRjZnFQbGd6TFp2YnJkeFJUOWVGdVJMdWo0SVdKMmxvU29S?=
 =?utf-8?B?K3p2Zjl2OTNpUWdtR0lEcEsxc1ZZR2xDZHEwV01JWUF5SCtrUCtBbDdKb1d6?=
 =?utf-8?B?QVE5Vm9rWERITlB5YkU5bVlXaVpDS21jaVlQWlJHMFlDcnp0L3kvWnN6Mk5H?=
 =?utf-8?B?bmxDRTRiMTV6RDRXT0tIdUFmaDZlOWhMaWJPUTJLajlGQ0U4Y0QwL08rWlMz?=
 =?utf-8?B?S3JGay9IanlTVXVlUERxakl2bGVCbW5RODVrc2hNQWtjOVdtR09CYmxyOWt6?=
 =?utf-8?B?Y3RZN2pxYnJEdmVaMG5TT1FUUmtEQkk4eWpkYWZWZUkrWTNBenZUcnRUUnVE?=
 =?utf-8?B?R3pXUjF6ZTV3ZEZpSENSQWdqTkI0K3hrdjJrYXo1QXRUbWM0OWdnUllyYzJ0?=
 =?utf-8?B?ZVdud2tYRVBJcjBCSUlhN2V0dkhDbzFsRkphUzloaDAza3dvNXBmSzRMY05z?=
 =?utf-8?B?c2R4RnhNVGtUVWkranJlQm95ejE5cjVqLzdZUFpLRGpHNzBNSGNiR3RGblhR?=
 =?utf-8?B?ajdzc0E2aVZEUGhBWE9ucmlXNjQzMFZ2bEZWZEJJUDhINE9GVjlvQlkzMTE5?=
 =?utf-8?B?bE1FbU1nWFlWWUJEa0h0U245MVJoSlBLOHBnZW9PUGdSeU1QbXhINHRwQ1Rm?=
 =?utf-8?B?MEFRbjlhSzNOU25BZTlUaDVSK1VJd2VMVkNlY2FvT0RYQUJRWVJFU09vVUx2?=
 =?utf-8?B?TnB1Z0F6VDV5YXpPUnBpcE1sMmhKbVRRb3ZmYWhBTXVyWkVrRU1NeG41bmxD?=
 =?utf-8?B?aHJOTDBiZ1d6RDRTWHo1bThqdmxRcXRKK3FEMDBVNTFCaC81UndJSHVDcTZF?=
 =?utf-8?B?RlJZbTNDbk1lVkJCUW5TaGswZG04N3pncGJXblZHbGRVaWZuZmZRUy9HbGY2?=
 =?utf-8?B?M2JqSWR3RXMyTjQ5MDNFVHUvVkl0OTVTbmJEQ3BIRWxONXJ4NzJMcGxUS3I0?=
 =?utf-8?B?VXBKeUtneHlXMmtUb2dNVEo0ZDRKVHFDWHJkaS9tQ1Q4aTlCcVV0TnN6L2ll?=
 =?utf-8?B?a1dha0M3NkUwSlFpenhZbjJNWWcvYUE4REZ2RWxuMGR4NE9sUC9LSGVNQ29B?=
 =?utf-8?B?Tkw4dmdEOGlxak5LWmFKcU90cGNyaFlWVDhjajNDWVlnVVczY2ZNSzRMNGRn?=
 =?utf-8?B?dTBTMUFGZjFscFpFMmhMeG5aSTJzOEhHNG5uWE5EcG8rTEhiUFhaZmNVSHFy?=
 =?utf-8?B?VDR3ZjVSaWE0ZEZFUGIrb0hIVDEvZ29KT2VaTUtaS3Exa2V4VFpHcFB5cGUw?=
 =?utf-8?B?MkdEK3JPcllLRzJTdklmekpqZHRPblhDR3JNSnZJRVhQVXY1NE5QUzE5Qi85?=
 =?utf-8?B?eU41ZDZ0czN6VHJLYUxBNnZxRVpCZDVrZVlwNUpLU01RWENYSmhVT1R1dTBW?=
 =?utf-8?B?NlFtS3RyVDkvZmFoZDBCclJzSXk1aXB1UnBtMWNoM2ZFb0I3L0JsVS9kZHBv?=
 =?utf-8?B?dUVIMUdDMTU4ZWhTS2RGNU9ZOVhkRXdUakJqN29oeCtPamFjVzRRanVPMFBs?=
 =?utf-8?B?ckR6Zk9rL3BDcW4vUytJMThOYTNlQmpHTmd0a1VFdTNYSnRvOFhxVUx4bGVS?=
 =?utf-8?B?WEd6TFVKeVk5aUhQclprRVdlajJMUjlGSHlXNkNWWWdXY0l2U09LUFRuMDJj?=
 =?utf-8?B?aVorWklKak9GUjlWR3FlMGZWNFp5STlabjl0ek52YStjTWtpYm14MGJoaTdS?=
 =?utf-8?B?VGhXRmg1V0xGV0JUczgxRmIyakYxdzAwdW0vSjgxendnc0lZNnh3R2tBOG5R?=
 =?utf-8?B?UVEyODlTNUk3cmNFb1JNVEZWYzVNbVF4QktPenFBQ3Zoa0RNNVFqRjJsLzRJ?=
 =?utf-8?B?Y0d5RlEwRndDRUVQVy9qYXN3NENrL0FGNk0xRXVUczVEbFpJcG1tcGFONGcx?=
 =?utf-8?B?MFQzRU9Bc0VrZlpJdXZ5WWx0OVhxd1c0OUpTUEozTTRSZkxtMlN4VCtFaGZ2?=
 =?utf-8?B?REM3TG52aWZ6cFFnVnVQSkE1MU9Ha0ZVVmtWVmE3YnJCbE5aV1U5SXZncFJu?=
 =?utf-8?B?b0dPenQ2Q0ZZUlJzbTMyUE5CYVdRbTN1b2NkaXJwK0t5TnFaeG4vNm9Sb1VK?=
 =?utf-8?B?dDFDUjNVSERxUVJWQXFCYVpFRlhDYUN5c0YwL1lGY3FuaEpKWkZwNEF1RUJH?=
 =?utf-8?Q?YS9EPAhIRKGnQtBRXW2g0xYX5aVcCSY0eXI8rh440QHj?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e8e43475cd2a4bfaa8a498e6915ceb1e:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	26848c63-1185-4ce5-ec3c-08de5e7bfdfa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|14060799003|376014|1800799024|36860700013|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDl4SWp3QldMYUpWeWNVSi9wTm1qc3c1aHB6c2pOMDlxWUl0NTRheS9MR2FR?=
 =?utf-8?B?L0c3QW1zbm95dzVTT2czMGRpTlhtQ1JTR2FvN0Iya1FkMjJIUmZoZFB6TWRU?=
 =?utf-8?B?RkU2YUdkeHpmTVo2ano0Z3kzN1FHMmxWRWFYeDd1WFYwbGlsZUY1YXFXVENL?=
 =?utf-8?B?UDE1SnBQNDF1eUk2VlhUYWh5QUNoeXpYL1ZlV0lxRkNIS04zZW10U2VSSVR2?=
 =?utf-8?B?Skg0L2pqY0g0UFNJdFM3Vk4vU01pNFVaOGpOSG9uUHZZVHU1M041VnJEWXh4?=
 =?utf-8?B?SjkzNVhiaTdXVkNWK2FqZitrT3RBZ2p2emlMRWFKQ1NlSCt5cFBEV3ppSXhr?=
 =?utf-8?B?eXVFN29SbGZ0cUJab09tUUV6dmdNWkp3ZkpoRGsxb0VwMXNleFBRY3lBbDZ2?=
 =?utf-8?B?eElzWkxyZjVOMUgrdXB1VWlqK2p1OTZoc3hWUGtob2tOeWtEdmVmNENiMDlJ?=
 =?utf-8?B?b0hVellkWFhOWWtzcmxhRVg5cTJQVTBXemhNSzZrclRUTEw5REp0NTNrY3JH?=
 =?utf-8?B?S0NXQU1UQWlJdmhGa0tQcGNJK3Zsc3RtUU9RUnAwTWY4aVptanZ1V2t6eUFB?=
 =?utf-8?B?RTBxS0JzTWNEL1VHT0xwNk9NSWtwaHFaMElsNnJEZitTbUptT1ArRXJMbER2?=
 =?utf-8?B?bkFYMnZjWmllckd3KzVLWGhBRFFScGJPZ1I1amUzKzM1TzI0dFpxbmJMc2tQ?=
 =?utf-8?B?QVpLc0FDb3Q2WXU0cXgrSnhKMGNUL2RSalI2UWw1SWgvenliVGFJdjZjNVk2?=
 =?utf-8?B?cmFPTkVWNHhOcEpKUFowaTQxeXl1cFhURGdlaHBPaGhJYW5Lb3RBS1NiUkdh?=
 =?utf-8?B?engwRkFZUnB0WElLRE50dmc5dXV3aEVQN05WOTkyUmc2bXFobEg4cm5MS1dY?=
 =?utf-8?B?c3N4cHgxMG56N3EzUk5TNEQ5dHk4Vk1lT0N3MEQ2KzNPYm5LbDdGUTNoWk04?=
 =?utf-8?B?eUZmY293R1dydk9oRldEYWh0dWRIWVZkeFNQYVJMdTNCZExKRXo1eC9ZMnlD?=
 =?utf-8?B?VmFWcG1xNG5FU0FIMmt4TG9IQ2wySkVCMTVCZHRhRjZOMTJrSEdrbzIzSEY1?=
 =?utf-8?B?RXp1Q0lBZjhPdjdZL2NtUlRJUHlaRTdPQmVnNjRJYU5xTkMycnJBVlRCRkYx?=
 =?utf-8?B?aWtqMWxTQWxHQzl4YmExZ3RraE54dUxGUmtZTDhaWDNqWnduSGJJOTFBNklo?=
 =?utf-8?B?dlBLYk0rU1kwVVYyTkJNb3hDYUtGMDdlQnYzaHViKzNlQ3pSOXc4c2s0K1ZN?=
 =?utf-8?B?Q05GZlBid1F4cVJSNE4xQ1lvOXVPZkhQY3RneHJ6aldkT0kxUG5lVlB4b3ht?=
 =?utf-8?B?bTZUek5lb3FlSm04U3VQSlZPOVowRWg3VStKaWRKQXRrWXdtWnZmd1lkMExM?=
 =?utf-8?B?cnh6Zk9YZDJidlBVbEh3S0tkbW5YZ0Jtb1VoZlh4cUFTb0VTWnk1VjI3V0Zm?=
 =?utf-8?B?VEt1b3g0anFpWlBUOWFIOXhEdVkyRVozY2FVTHplMExJd25VWGFyS2ZiOHA2?=
 =?utf-8?B?c1dITzlMSlU3MzYxMFdPWVYrenBrd1NNampBcGpOakxnZGthdXdpTk5IOFBG?=
 =?utf-8?B?dU40a01TQVJFNDdubkRPMnM2bGhCQW5PSUZ4OXljWG93OVpPQ2hDWEJvYTJ2?=
 =?utf-8?B?dW5JZXBjcm1vb1RTVVZNWU9CMHdEcEJYdmM0SExLU1NpMnlKcFhNR0FoVDFL?=
 =?utf-8?B?Q0ZtaDNuNll1RE0yYzJBYXZCcGhVdlpNQW82eGE3dEN0MEtYeFFUR2hsVmZW?=
 =?utf-8?B?TmpveDRoSkswcCtPOU5LVXJTOUJxeC9SMFhMMU5pN2M0ajlEQTV3MHAzNUJE?=
 =?utf-8?B?Z2NJQm4rQndnVHcvRGw2elZkTHhrV1BSbGRpckdSNVlyanBWVHZ5WHdkV295?=
 =?utf-8?B?RWhGWnl0Sm04c2JERjdOdEdGOUNLY0FaTnRmbElwclVwa2IwU04zNVM3TmlZ?=
 =?utf-8?B?VmJmSTFCTmtrZk82dktqT0h6ZlE0VFZhcTJNOXQ5dGpjWW5RQjVZandpS3hl?=
 =?utf-8?B?Ym5ZdzNDN1VGTDRYcUZYaXZQVFZ1WTJvWTduckswV1U5REFwVHNtTEVIaDg2?=
 =?utf-8?B?WWJ5NmpsUm9PN0V3Vm1SUGJ1SlBHNEhpNk5mUHdxS0VlSSt2ZGFRUVBTeWpH?=
 =?utf-8?B?WlBXaWJaOVROZHhib2VlMitZMExISU5yM1MrSFZXN1VObnZwUEhQdFdoTjdo?=
 =?utf-8?B?UkZwZUFYclRsZXZVTU5tOEw2N000RmZrVHpqWWRLbTNaZ3FzY1hqSGJzVElm?=
 =?utf-8?Q?T4rCG+gKYbF7yhPpcgPRnbOVY24HZPWxzWtWYi3+Y4=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(14060799003)(376014)(1800799024)(36860700013)(35042699022)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:32.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8f1041-83d9-431f-3aea-08de5e7c0712
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9288
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
	TAGGED_FROM(0.00)[bounces-6340-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EDED9A3214
X-Rspamd-Action: no action

Some Renesas SoC based boards mux SD and eMMC on a single sdio
controller, exposing user control by dip switch and software control by
gpio.

Purpose is to simplify development and provisioning by selecting boot
media at power-on, and again before starting linux.

Add binding and driver support for linking a (gpio) mux to renesas sdio
controller.

Introduce generic helper functions for getting managed and selected
mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v7:
- picked up reviewed-tags
- fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
  and enable it by default when COMPILE_TEST is set.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- fix another kernel build robot warning: undocumented C struct member
- Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com

Changes in v6:
- replaced /* with /** for devm_mux_state_state function description.
- collected review tags.
- fixed checkpatch warnings (space-before-tab, void-return).
  (Reported-by: Geert Uytterhoeven)
- fixed use-after-free in mux core mux_get function.
  (Reported-by: Geert Uytterhoeven)
- fix mux helper error path uninitialised return code variable.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com

Changes in v5:
- implemented automatic mux deselect for devm_*_selected.
  (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
- because of semantic changes I dropped reviewed and acks from omap-i2c
  patch (Andreas Kemnade / Wolfram Sang).
- fix invalid return value in void function for mux helper stubs
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com

Changes in v4:
- added MULTIPLEXER Kconfig help text.
- removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
  not required for all devices using this driver.
- added stubs for all symbols exported by mux core.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- refactored mux core logic to silence ENOENT errors only on optional
  code paths, keeping error printing unchanged otherwise.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- picked up various reviewed- and acked-by tags
- Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com

Changes in v3:
- updated omap-i2c and phy-can-transceiver to use new helpers.
- created generic helper functions for getting managed optional mux-state.
  (Reported-by: Rob Herring <robh@kernel.org>)
- picked up binding ack by Rob Herring.
- replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
  commit descriptions.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com

Changes in v2:
- dropped mux-controller node from dt binding example
  (Reported-by: Conor Dooley <conor@kernel.org>
   Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com

---
Josua Mayer (7):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      mux: add help text for MULTIPLEXER config option
      phy: can-transceiver: drop temporary helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |   8 +-
 drivers/mux/core.c                                 | 178 +++++++++++++++++----
 drivers/phy/phy-can-transceiver.c                  |  10 --
 include/linux/mux/consumer.h                       | 108 ++++++++++++-
 7 files changed, 277 insertions(+), 63 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



