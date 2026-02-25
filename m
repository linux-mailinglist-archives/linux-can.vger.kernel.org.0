Return-Path: <linux-can+bounces-6625-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDYUJ5benml9XgQAu9opvQ
	(envelope-from <linux-can+bounces-6625-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:35:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2219693C
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D05A73037274
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D286396B7A;
	Wed, 25 Feb 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q9TrOdnn";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q9TrOdnn"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515A395259;
	Wed, 25 Feb 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019300; cv=fail; b=BV01/dZKibtpo3mwY07TpDKECQaBqQOO32aMR/DTzT7iwQj7HBUKvAHNYU34K2OL312IrVJD8z6URh+Y586UQ5nLH9WjDMwcetfFULF8J3izKwlL8mgkIuNZ7OMBxpvehiD8yVPvqrXUKhOUO1qgwAe+NFVPZvSDuQGo0RIKqAo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019300; c=relaxed/simple;
	bh=4TGLFmxJmD40Q2ad+ZwACFXXIrUowOXJqwTA+Q92VTQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ijfc/VdRuKDa5QD+apSv9UdnSickrbFuDM0Y6P09HGPn1TdK5wQt7C9xI48IAqHU5jBttgdMDib2MTAjIIYhC+GmSOP4u9QTodRNsN9eMNe9ZuGvWzunhAo8/h6QwWqQ/NMD2adoPm3T94fR2vK39sjNUqtu9D3MTtpACqGKgTw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q9TrOdnn; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q9TrOdnn; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c5PSEDXNq33CpL+Sb1bmw7JWNJLw0ru/vbF4pbaZ2S6dxeMm9xMAyRZX2760EZvjmNyNJPAYvpcJ5VgT8ljCva5D00OijvJTHodXd2i7vrVDHy81bOi3c5CrD7vEeBtPatySEiMhR7gdDTdKKrxWlT3ZwHI8x+QukIaaqd1rYJN6m5FcdoM6d9uM2tW4Dmegu1cYdXY5nPXZwEyP9RiBZ/9J+hFK2Woi2CtjzIK9q6KzGzznJJHpSmXtrZ6iIzKW1Kq7ezdbo9CliEKtiMwM0SGemNdtU67Bch6V42E7dLmmnVH7+QCrBUVkFDqmFF8n3MArC38mYG9UZcMHl63pYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO4qj+wMV/XwBYmp/8IXtJ6Epr8snhs/g77Ygn3GsgA=;
 b=acgR0SIGuUCnBrK5Soa/XYwXxbAc7Np4gZtAs8W9O6iRLXI42gYyPU8vpuCsN8JTbBjo8AlySf3qpJPXTubPzE7Qd2girfjfau9jXuBbEdq/MK82/r83G/VJ8bCs6sCdKZqN6leGGEQZ7Wk9EeIGlk58jrEmO/y6fp7mnQEF/Ll6g9HYEj/cS/RA2OriuYwx0St1B/AOGrQkGPJa1Kx4AjVwYGTmvdThNsljZoMC8Fd52CVkCcZ5hmVAkXYHDxNnTq2YzcDNuyoaDFaMSllj+gH7BO3Khrm2vv5RCpfsAE7wPVivsujL6hqZBLYGT6OkoBaNwo2qIiLZMf58ks+8EQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO4qj+wMV/XwBYmp/8IXtJ6Epr8snhs/g77Ygn3GsgA=;
 b=Q9TrOdnnpIzlSIptFLLoRHiR/Whz7uW7kB2SBfAdBtdDInfLSOenD4shaqnxeXI8J8RjWgrAlMm7r75ntfqXBCL4YIBMo0t7tNmEz0Nzsdfh+hDUb4Vdea6hJx/punyq9F1O+Lyx7SZM4dywtuJ//08CaNQTu9Hd5Mhll+1ZWxU=
Received: from DUZPR01CA0242.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::14) by AS8PR04MB8310.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:49 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::25) by DUZPR01CA0242.outlook.office365.com
 (2603:10a6:10:4b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via
 Frontend Transport; Wed, 25 Feb 2026 11:34:49 +0000
Received: from emails-4851394-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6D887805B7;
	Wed, 25 Feb 2026 11:34:49 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:41 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPPrissdTn+3vsmm2EZPPcEoW0Xrg1ze9sHa9RR+fwfzJzwa9dozk6hL5ZKD/yqEdF38xNlM8OFozf2MDCNsfm1XHUNr5CSGPZhORjnMXG9vCEh3ypOkYcsVv//J436OpKKIxt6ifSe0EJl/Mi51CdFnTY07jV97mMsjluGaxJPD/tkjRRjrOb5TX/bNNbcUJue2cEIz8Hunj7FNFPOb3EhS+4LTGtA5sLOEUuGP8nS+xG1TUKI24WEGvOkvfTM70rzPS3hyij6IKheza2VdownGFpGkBTS7AMkBUVMH0y6KSfMrYg3CeWOpVSkcnkl3ECu7hxpZzGW7i5EuL7TuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO4qj+wMV/XwBYmp/8IXtJ6Epr8snhs/g77Ygn3GsgA=;
 b=YO2GGOm4bk0O5VTt2XNCHii45Tf7GEDP9rQwMI8HvfCWFUQYmX9pWxoAAPvXjKHAHj8yHkTriixvAsTNY+JBCMFVBCTdohCCxtkmY5kQpa5quQjmsgFMAEwVfIAybXf1oEjHAUh0Ap07RryaUg/DRXoxw87OOWAyI65fGWMA+gaEzC3IfLsHq7KvLQ7LerRQ5jckDnXB4txKUFLQAUT1aOYHdi1zrAZWM76w1eA98egp32nzIAKMBlkXzVgdqIfna8eonW1RXm7n5Nk0pDQbJHqV5OMR2zL7ogdsivcyrULl0UfjBeSy3rnIfii2Stm2FrQYMOVr327YmKqd2/InCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO4qj+wMV/XwBYmp/8IXtJ6Epr8snhs/g77Ygn3GsgA=;
 b=Q9TrOdnnpIzlSIptFLLoRHiR/Whz7uW7kB2SBfAdBtdDInfLSOenD4shaqnxeXI8J8RjWgrAlMm7r75ntfqXBCL4YIBMo0t7tNmEz0Nzsdfh+hDUb4Vdea6hJx/punyq9F1O+Lyx7SZM4dywtuJ//08CaNQTu9Hd5Mhll+1ZWxU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:36 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:17 +0200
Subject: [PATCH v10 3/9] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-3-1ee44f2ea112@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7267:EE_|DU2PEPF0001E9C3:EE_|AS8PR04MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8edc3b-8dd1-4ade-315f-08de7461e2a1
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 Pbbk3V5GGgTc6kkHJB4KJ12H0cObVN3zKcDa3+LZDIL/mERfMjK0sO36/zNvbFZ1tjKk/FdUqVegPNXvi8U6Ln7US91/MKbRoF2S1IHrpM49EoCd8v2X1JaJfgFwX59yPsgdvYUU5+rMWVuIx9U1FKtM0fNQf6AfUH5DdOW1xHqaOD4zwUT1ayu3xQdY8aHzdJWYEKpCBDayZyWtOhABGHGrwNEuEuDLDxxziOY/CIaGNGSowbMYoA4slQqvQe8lXR5aXyXnzvdIWbCc7wP1gGRkC689BFh75jPm/x6nrcijB+3WsvsPA2xge5OjmUnkn+jwgM1G7DgtA8/MPWE4JRH6ocaFWbxTdSkjuxKW5RANoQ6sDCKkobWIjYeQ+4ELLpnrfhll2nwyeA/Whx5Vcsn5pc5zP9Np57I6mGKhDb0wY11nQYE2MXbQX4XboReKyQsQ140uVWV9Al3pjb4DSV6ys4katNUSKBwcdAeqwbT3moRtYQz8KApIUZfHe7VENtLtwo91vRyoiALho7RnCydKt1hmB0iGtuFwAUMs4zK2tZsSyfnPMO60UNGiEpW+kX8BwqSMdcbZdDm5x/WAERUEsbiqNFWVa2zgoTinxVljqk7N1ZYeKE71BwPxfKpXa1NKeYBRHrSd2Fh2ChNdovhqPXOgVAKkvsxxE5bflCP70aLtI8s6jGd7fspJgdpJEw1OavaUAn7NtyLFb3Yge+bZus1tfroEvqf3qYgfgW9qV6NNpS4zIQdKcRDJy84wlvt8SgT64tRd/focIxYq9wg8v+6uOphgQU5qwnYqPp1JxlP+Vq55vZ7FeDCftlUj
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e6fc071f25884d7aaae8cad0ecfd18ea:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ecd8e9d7-78e8-466a-d825-08de7461da6c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700013|82310400026|35042699022|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	HSwzgjtQjFxBKVw4uQPp30ewSaG611duZhhZDSKcnIIuvcNGSNXcvR8Zq250kowNd2+or/Iz1uR/Jm0HIk0Q6obGyVv4EwqsDHNL+B5kAEwPT7HKzNYPWi0mTJXSC2AT9nTMrEJIPFA1wQCyf+IF8A9rx05cyJSZE8kQLDZDA0V+eB5F2sIKIyyTXyu8+4RYsGV4MHTihwZUHmWcEfzmhB6KltNoHFnyQWODTW1Z0AU3WeW6I56jDUmtaLsxgaiRyHIlSSOL/8B1DLA+DiOg63d3zI5MewN+8iYQnh5u8ObUZfLocoCiFKdImUb3ftuDFyVFHgM8yMSdUDSNgdb7PrHCMSlcDzuf1rP4/c2n/P9DXWYjKLsUXpziq2JegvaBfes3l+0gcAoz/n5Hh9ux9BenpdbfR6b/0xhQy1kR2PvUQhvddTOT7SsyAnUd8HNrPbdZoHGzUXd22Id7PzZfHmRUfSHH/wa6Z3+c3kxhR4LEAKUqoUrpCEzFz+hEeM/OZFQ1ZHt/tEz1po2h7XXB7YL6gTyR0Mx+NE/wHBwLscI1Prnh3LeL4aH0pKWVCkiBkODF0oEpZKcSS7/SIYn12gRfw4HMyINkySHCgBq3Eoh5sQhZoSkXQl5HMa+GgzSWwlqMg+YpgrtKiosmoXecExD0+qw/GjnJJUQRptwdnpCOpStWUbSaS/AVS3WTyv1yMVKqpN8dl00ZTOb0A9NnKUh1YECUs7Szpb1zJL7AqSZsY1DdD+/TbAUUro+O4rYcUpTo6JMOWilw9SsBTp+sgifgF7OgwObPBanerD2+n5YiLKS43qhVjXWbNkKBC0vT7b0DJS8l/HCpcEolTWNPp5WhtuUzWjqALq29OBBE3t8=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700013)(82310400026)(35042699022)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9/rFVoE7SB+SLeL3jjuju7ilnzinQEus1oznv80+y1DX/th6Ve8i1ywK1k5QbGdGSvfTgrtRCDNSpsQBPKxEXILWHOXgpIsTyKP7ek7RpeWqkogrGzJkdtXMs9oDsCdFgbzgZ5N20Ypv2BxAk2QLzwTTLImCoyys71NGxq18JCHAV/LBcyLKZhAwXPP4DorVrqw0B4z6+RgkgsBJwlKSaDcbzU8e8ckHp8eysinD3OCgEkV2otlLNZxIp1ONa6Feok0olpAO/2VvQ/4r2ko6iSoK1WQvRWZZSZb6jB2T1AyhPPJLEpKEu/n7IVTR8QGbm+szvtbsPEPNKY9T+c/rw53Po7j6WeSUgVclTkGtBxaysBWwXFtt3P+DColgHal1LJemXXWXmFmQSxYOAwiTpREXqXB7rTK1wtEt2bWIoaQrfW9sS17Ak0l3kXlq3JPM
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:49.5630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8edc3b-8dd1-4ade-315f-08de7461e2a1
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6625-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,sang-engineering.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 43D2219693C
X-Rspamd-Action: no action

In-tree phy-can-transceiver and phy_rcar_gen3_usb2 have already
implemented local versions of devm_mux_state_get_optional.

The omap-i2c driver gets and selects an optional mux in its probe
function without using any helper.

Add new helper functions covering both aforementioned use-cases:

- mux_control_get_optional:
  Get a mux-control if specified in dt, return NULL otherwise.
- devm_mux_state_get_optional:
  Get a mux-state if specified in dt, return NULL otherwise.
- devm_mux_state_get_selected:
  Get and select a mux-state specified in dt, return error otherwise.
- devm_mux_state_get_optional_selected:
  Get and select a mux-state if specified in dt, return error or NULL.

Existing mux_get helper function is changed to take an extra argument
indicating whether the mux is optional.
In this case no error is printed, and NULL returned in case of ENOENT.

Calling code is adapted to handle NULL return case, and to pass optional
argument as required.

To support automatic deselect for _selected helper, a new structure is
created storing an exit pointer similar to clock core which is called on
release.

To facilitate code sharing between optional/mandatory/selected helpers,
a new internal helper function is added to handle quiet (optional) and
verbose (mandatory) errors, as well as storing the correct callback for
devm release: __devm_mux_state_get

Due to this structure devm_mux_state_get_*_selected can no longer print
a useful error message when select fails. Instead callers should print
errors where needed.

Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
property presence check") noted that "mux_get() always prints an error
message in case of an error, including when the property is not present,
confusing the user."

The first error message covers the case that a mux name is not matched
in dt. The second error message is based on of_parse_phandle_with_args
return value.

In optional case no error is printed and NULL is returned.
This ensures that the new helper functions will not confuse the user
either.

With the addition of optional helper functions it became clear that
drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
Add stubs for all symbols exported by mux core.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 206 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h | 108 ++++++++++++++++++++++-
 2 files changed, 279 insertions(+), 35 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index f09ee8782e3d..6033da0a9e17 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -46,6 +46,16 @@ static const struct class mux_class = {
 	.name = "mux",
 };
 
+/**
+ * struct devm_mux_state_state -	Tracks managed resources for mux-state objects.
+ * @mstate:				Pointer to a mux state.
+ * @exit:				An optional callback to execute before free.
+ */
+struct devm_mux_state_state {
+	struct mux_state *mstate;
+	int (*exit)(struct mux_state *mstate);
+};
+
 static DEFINE_IDA(mux_ida);
 
 static int __init mux_init(void)
@@ -516,17 +526,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-/*
+/**
  * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-control on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, bool optional)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -542,7 +554,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		else
 			index = of_property_match_string(np, "mux-control-names",
 							 mux_name);
-		if (index < 0) {
+		if (index < 0 && optional) {
+			return NULL;
+		} else if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
 			return ERR_PTR(index);
@@ -558,8 +572,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 						 "mux-controls", "#mux-control-cells",
 						 index, &args);
 	if (ret) {
+		if (optional && ret == -ENOENT)
+			return NULL;
+
 		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
-			np, state ? "state" : "control", mux_name ?: "", index);
+			np, state ? "state" : "control",
+			mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -617,10 +635,29 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	struct mux_control *mux = mux_get(dev, mux_name, NULL, false);
+
+	if (!mux)
+		return ERR_PTR(-ENOENT);
+
+	return mux;
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_optional() - Get the optional mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ */
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_optional);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -657,10 +694,13 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
+	mux = mux_get(dev, mux_name, NULL, false);
 	if (IS_ERR(mux)) {
 		devres_free(ptr);
 		return mux;
+	} else if (!mux) {
+		devres_free(ptr);
+		return ERR_PTR(-ENOENT);
 	}
 
 	*ptr = mux;
@@ -670,14 +710,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
-/*
+/**
  * mux_state_get() - Get the mux-state for a device.
  * @dev: The device that needs a mux-state.
  * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
 {
 	struct mux_state *mstate;
 
@@ -685,12 +727,16 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	mstate->mux = mux_get(dev, mux_name, &mstate->state, optional);
 	if (IS_ERR(mstate->mux)) {
-		int err = PTR_ERR(mstate->mux);
-
 		kfree(mstate);
-		return ERR_PTR(err);
+		return ERR_CAST(mstate->mux);
+	} else if (optional && !mstate->mux) {
+		kfree(mstate);
+		return NULL;
+	} else if (!mstate->mux) {
+		kfree(mstate);
+		return ERR_PTR(-ENOENT);
 	}
 
 	return mstate;
@@ -710,9 +756,66 @@ static void mux_state_put(struct mux_state *mstate)
 
 static void devm_mux_state_release(struct device *dev, void *res)
 {
-	struct mux_state *mstate = *(struct mux_state **)res;
+	struct devm_mux_state_state *devm_state = res;
 
+	if (devm_state->exit)
+		devm_state->exit(devm_state->mstate);
+
+	mux_state_put(devm_state->mstate);
+}
+
+/**
+ * __devm_mux_state_get() - Get the optional mux-state for a device,
+ *			    with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
+ * @init: Optional function pointer for mux-state object initialisation.
+ * @exit: Optional function pointer for mux-state object cleanup on release.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
+ */
+static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
+					      bool optional,
+					      int (*init)(struct mux_state *mstate),
+					      int (*exit)(struct mux_state *mstate))
+{
+	struct devm_mux_state_state *devm_state;
+	struct mux_state *mstate;
+	int ret;
+
+	mstate = mux_state_get(dev, mux_name, optional);
+	if (IS_ERR(mstate))
+		return ERR_CAST(mstate);
+	else if (optional && !mstate)
+		return NULL;
+	else if (!mstate)
+		return ERR_PTR(-ENOENT);
+
+	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
+	if (!devm_state) {
+		ret = -ENOMEM;
+		goto err_devres_alloc;
+	}
+
+	if (init) {
+		ret = init(mstate);
+		if (ret)
+			goto err_mux_state_init;
+	}
+
+	devm_state->mstate = mstate;
+	devm_state->exit = exit;
+	devres_add(dev, devm_state);
+
+	return mstate;
+
+err_mux_state_init:
+	devres_free(devm_state);
+err_devres_alloc:
 	mux_state_put(mstate);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -722,28 +825,69 @@ static void devm_mux_state_release(struct device *dev, void *res)
  * @mux_name: The name identifying the mux-control.
  *
  * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
  */
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name)
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
 {
-	struct mux_state **ptr, *mstate;
-
-	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	return __devm_mux_state_get(dev, mux_name, false, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
-	mstate = mux_state_get(dev, mux_name);
-	if (IS_ERR(mstate)) {
-		devres_free(ptr);
-		return mstate;
-	}
+/**
+ * devm_mux_state_get_optional() - Get the optional mux-state for a device,
+ *				   with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional);
 
-	*ptr = mstate;
-	devres_add(dev, ptr);
+/**
+ * devm_mux_state_get_selected() - Get the mux-state for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_selected);
 
-	return mstate;
+/**
+ * devm_mux_state_get_optional_selected() - Get the optional mux-state for
+ *					    a device, with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+						       const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, mux_state_select, mux_state_deselect);
 }
-EXPORT_SYMBOL_GPL(devm_mux_state_get);
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional_selected);
 
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..a961861a503b 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#if IS_ENABLED(CONFIG_MULTIPLEXER)
+
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
@@ -54,11 +56,109 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev, const char *mux_name);
+
+#else
+
+static inline unsigned int mux_control_states(struct mux_control *mux)
+{
+	return 0;
+}
+static inline int __must_check mux_control_select_delay(struct mux_control *mux,
+							unsigned int state, unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
+						      unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
+							    unsigned int state,
+							    unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+							  unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mux_control_deselect(struct mux_control *mux)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mux_state_deselect(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_control *mux_control_get_optional(struct device *dev,
+							   const char *mux_name)
+{
+	return NULL;
+}
+static inline void mux_control_put(struct mux_control *mux) {}
+
+static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
+							    const char *mux_name)
+{
+	return NULL;
+}
+static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
+							    const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+								     const char *mux_name)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MULTIPLEXER */
 
 #endif /* _LINUX_MUX_CONSUMER_H */

-- 
2.43.0


