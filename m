Return-Path: <linux-can+bounces-3266-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0AA748C0
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1267A84E9
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7803215055;
	Fri, 28 Mar 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G0jlliSW"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19F1E833C;
	Fri, 28 Mar 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159289; cv=fail; b=Z6SpmP+PTxPGk9kzsGRvgwKDS0C1crwi33lNhDRyr935EFwzjBjuhsMOnoHl3YQwO1vFA7EAAaShtzBeBhD0vs9gB1DqiI8loilxeutK6z3lD0kC2gGflKPBYb378Z6lVO74mrHBkDTD7boYdkXL3oXtdA7MIXI8Ab4Oe7anGMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159289; c=relaxed/simple;
	bh=101LxON5j6Foelc2QzmxTgaGjetJ3C7JJtDPqNmCOJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVfzDdcApKoDgehoWkAeM1CUgJh0zBYzRGe71db5+1hz369PmB+j8y/osG9z2y6LPCf3UjL96QUQ2HNGESbzjI7htLQ5xXYNAgmlueH3IgnuxihgdiRk6ENbfNaT0LtXk212PSXtCF8e/GM5rw8LGknBNWZIfQzTsP1ZcxjyEGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=G0jlliSW; arc=fail smtp.client-ip=52.101.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz8IS2e2fCYYR2dYVtnSjiHqpRow4SNHnXJTwccgj9GAhax9SDh0k+uOTTPNZLHwbbeEhNIxMQnC4B6s2nfA++k2tAbGM5KUbB8WMIznR7qduZy6Tt7K2a4dxhg40761AzPSifTAxa84Ekft+Y7oDDL/CzYQzCxFzeEDZnN6M6C+SR5ScIKbedR3DWwRAsNx2PRLEYDOqSoP51SOaReIb4AN4V2cF4rEjkfHLnySaGq/dZ7jjxO4TPwQqj/KtwBhAo4L3HJhLAFKdoxpz5dQXaVc9gVgKm3O8Z4ly0H5CVC5GqoOc8VxJbdryo8cffn685AhBG6jUSfmlpRzzco0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=101LxON5j6Foelc2QzmxTgaGjetJ3C7JJtDPqNmCOJc=;
 b=NvY5utvxrCTn/3EZwsg2wGpDmBywrQiVx9pQrLgkVoamZB/celOUjNL+weOdFX+tXbwmfd9s9D57AYFz89TueqQvUCvVQB6JOCBGJhDwv2fbnTPFsZBqIIxjbB7Fo7uTlwPqFwO+LF5P8FsF59OTjNsoIXoF5vz9wjDrylCchQ/BhJrp9S85S5NAP3CFOOdUVUovbPUEN/1oXwuEWBEZxKM97fjDcFdBtgp2+E9NKTQQdd1jkpM9dA//Ws3w21fekDIgas/X4eQ9XZUPQEsnoQc8ACgG5T3+eU9YKy6TsEwDYp1gjpWU75qkMlnaP2LEO8z4jyLKAf1b/gMHuCCtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=101LxON5j6Foelc2QzmxTgaGjetJ3C7JJtDPqNmCOJc=;
 b=G0jlliSWDLmFUIqigVz/rvMFkU/Liy3gBKHk/XMwdRDXXWu7e3e0khyuhUfvlBIYiG5/VYpD/CzQ5WtlLLeYDcW3kFjX5fw2YoUWWU5gmKqURJkXiAm2yDL9YvGHgPV/NKIbZF+5zjSSg8r02qlq8hlyZrXQiYdfrbEDJAuz0Q8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8512.jpnprd01.prod.outlook.com (2603:1096:400:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Fri, 28 Mar
 2025 10:54:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:54:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
Thread-Topic: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
Thread-Index: AQHbnkmA0xYVo6ORm02TL+SjeOOwZrOIXquAgAABGvA=
Date: Fri, 28 Mar 2025 10:54:42 +0000
Message-ID:
 <TY3PR01MB113467D894782F210DA15345E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com>
 <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
In-Reply-To: <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8512:EE_
x-ms-office365-filtering-correlation-id: b7b0e890-010e-4c62-f1d5-08dd6de6f1ad
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y08zdVNyQkZIOTBMRFU4bDFRZzBIbTBXeVJ0MjZMUllPUXhSTDdUYzh3b1Ru?=
 =?utf-8?B?OElsNkUxbjR3bUNSN1BaVGdjUnRaTTBLTno3VU1sT3pwWi83dUQrSWtvck9E?=
 =?utf-8?B?RzFjbzdWbm40WnF0Q2Q1YWo3KzBHcWU2d09HajVHTlhZTTZyd1U1Y3Z1RVJq?=
 =?utf-8?B?QlRFd0ZzaW42RXlwYlAvY0pHeE1BbDRERGpmcXA3TkRQQ3lvcUpyTWE0VE5W?=
 =?utf-8?B?dWMvMG91UmJtOWQ1RlNnZXJMbjhjUXU1SXB3RmJqQnJzMTYvdnpIWW5VbUpi?=
 =?utf-8?B?MWtJdzJsdWVreFJ6Y0s0OExPbUxLU2tUSjI4dFZhc01ZdFpOSSs0MlFZSDQr?=
 =?utf-8?B?NlBEUTV3RGNwNmVGakdMS011WCtVM0FWYVhzSkJwRm8yRGxhOEtWajY3cldk?=
 =?utf-8?B?VmUzOTViNkNhT2V6YlhOSk9qQlppVFRscFBsanBhOXZMc1VCeXFmeFduQmlG?=
 =?utf-8?B?WklQUEZJMVdna09BcDBzSitVdjdpOW5iakpHSkpGVnlsYVhMckdBanB3WTFD?=
 =?utf-8?B?RStOS0xFTCtaNUtTcGUwQW50QjFqNjBXSFhyN0ZwTENpRjI1bWdBU1NtV3Bl?=
 =?utf-8?B?d1pYdVpGalZkWGVUVWFtNWVNUE4vNVFIM2ZKS3JuT2VOR25WeGREMGZNakJJ?=
 =?utf-8?B?UEdPR3lIcC9wb1NLVCt1d210alQwcXU3NlBhUTFpbWpOTzRzT3Nqa3Z0SVRB?=
 =?utf-8?B?czhmdnJ0R0RMWld5ekJQTThqZkpMQVNtNDNCVVRHQ1RVM2p0YW1wWFQzVlNH?=
 =?utf-8?B?WGc4NEpvTDl6NURkZlpmVmZKY1VRSGRmSlhUVTdtbWs1MUZXc25aS0RJejd6?=
 =?utf-8?B?V3d3cXpWckY2S2hlbUNpbDNRbDhla0wxQXc5VjBUZU1vSVMvZ1Y1QU9naFJT?=
 =?utf-8?B?aWNoRUtIWEIzYkk0ekw5QzFCZDdubGJQa2NYUU81TzBlSDc4Nmx3S241bzJ0?=
 =?utf-8?B?MXlzUXdoTnQ4RDA2bExSckhyTndhZ2lLNjRCbkl2c0RTbXh3Q3dzNmZjUzcw?=
 =?utf-8?B?K0VNVytUTS9HMTlNYUlzWDF3dll3eEZmUmNvUi9XR1ZxQnhEM0Z3MHdrU1Vk?=
 =?utf-8?B?b2ZjdE96TVZJNUpTTFFsZUJUS0luaSt1aFdxYTlzTmxqUzEzbVhNNUJWaGU3?=
 =?utf-8?B?RE4zcXpCd01IVzRKQXBKU1dTK3NWY056dHZxSDJDZ1B5SjlaWXpqRHJnM3Rp?=
 =?utf-8?B?SVdZUTlPaC9rRG1WVWh4TlRFUzhOLytCSU44ODhuTlFSanpvWXR5a21NVGow?=
 =?utf-8?B?TFAxQU10ZnZON0wrcmRaR2lKT2NrS3FsNU9JQmVDOTBDVXcxM25Rck5uaVU5?=
 =?utf-8?B?NFBXQVhqaWtyWXYzbVMxUVYxbnZ0MWMrUG5xMmxmQW82R0RsWkhNUWdSRlov?=
 =?utf-8?B?SWVnL1dKbTlCVWR0WXkremNiQ25uQWR1R1E5YWZ6OWE3QmFhVkRWYWNkRVAw?=
 =?utf-8?B?QmZWZ1hXR1pFSmUxK0hseDByR2J5a2lRQ1R5dUE3WWJvNHJtWUFTZVhIZnZL?=
 =?utf-8?B?Z1R3QmdwV1pGTGs1ZnRwT1Vnemw4YUFMNzJyQ3E2Q1RkcmhhS1J6UmJrMkxy?=
 =?utf-8?B?Y29aRnpydGp5TGpBRENGcks4WEtpdWtJT2o5eEVadlFnZ2N6SUFqWFBBakVL?=
 =?utf-8?B?V1lHNVREc1JGdTNTS2ZMaFVnSUZWMHI0RW5yZmdLT3hJVjNDMEJzNU1JL1pp?=
 =?utf-8?B?bmU2aXEzaUgzZXhZcThzQUpvaW85NE5jZHJwelBSMFlURTNJWERNK2ZvRUFK?=
 =?utf-8?B?b29DK3pxNzBRUkJYdEh0LzFNVVN3ZW43Qk4xcHN1aGovYzFteUpMTVU5M3BJ?=
 =?utf-8?B?UzhnVkJCWTdUWk9uSk5PZFVDWEtpUitsTWdSaEQ0cXo5L2ZhYjJtZEJSaFo0?=
 =?utf-8?B?NnlSRGJ5eTlyd3R5YkhvSEdNOXdLRmVkOUwvZVZHSS9haGIxdVRmcGtRclhW?=
 =?utf-8?Q?VbbhnKG77XsveOmsAq1PneDvKH9q6vN+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFR0UFovT0VFRVM2YlZrMXhtOXlialQ3bHpHREFmTGxqVEJQdWZ4QmVjNHZK?=
 =?utf-8?B?YXB3SHE1ZDJ2VHA0b0dOZy8veWNydDJJeVIvRWNic1N1MjlmMWswNGF6ZW9Q?=
 =?utf-8?B?WmEwTDQyVUR1WjEvMHFPMHF1TDVGcVdKZlUxL3R5YkhUT1lycWk2clhXSUtI?=
 =?utf-8?B?NS9hdUhzcXFSQ0pBQ25Rd0dDN0RncnNJVnZ0aUFJMS96TXEvdHQwREVQRnZV?=
 =?utf-8?B?RDNha3lRVVJjeXkvWWE5REFYTUt2cjVXT3lNaDhLb2xXbWFpd0hId2lDWWc4?=
 =?utf-8?B?cVI1YVlRQkp5aXJBY2FRaWJabllGMDZxNEpWT3c4elgrQm9RUWdmaC9SSDhh?=
 =?utf-8?B?dG9DMWZOYmRidHFmamVIdTQ0N0k1eENVM3dlVG9HSHlKV2lYdjBIQ053VmNZ?=
 =?utf-8?B?RzNXeVJzenlxVkk0dHZqY0F1U29KS25seFF5bjdHaXUxdHUvQmhQb24yUlBm?=
 =?utf-8?B?amY1WmJsK0RPc2RiTXYvam05enBCWG02bE5TWnpNeFV5MjI3d3FIdncxS1dL?=
 =?utf-8?B?ZTd6bXMweklsZWNmaTQ2ZlJTOW95MlFEZ2xzamdtNjRmb1dEQmthaGVnand6?=
 =?utf-8?B?cTU2dkc1TEN1VXE3Si9oL21Od1dQckZxRVlZbElHN2ViQXJ2KytyK3d4RDVJ?=
 =?utf-8?B?bFZDZ2RFNDBWcnF4ZmhpekswNUdTdmZNQ3BJVXZLcUNkMjdvWERoeDZaOXdU?=
 =?utf-8?B?VVlCYkpKc1NzRHNVT1JKTGFDbzJQcUptWXkvbCt0TGgzOVo0QVlNWmZJYldK?=
 =?utf-8?B?OVM1WUdMckZNYUlOYTJNazFIbzJYSzJ0Uk5ybkVJUmU4L2JjVUx2VEhuQlJV?=
 =?utf-8?B?dUlITXZTUVlFcFJ0WmdqZlhrc3l6dFc0Zjl6WmJWeFZDZmQ2QjFkVEtkVDdz?=
 =?utf-8?B?WjlBSzRGZng3bHRLUHpNb3pVRW1OUWRrZ3huN3VRaWtMdS9WeG0rSGtQWG84?=
 =?utf-8?B?VTQyRjU2bEpHME1lTnBCaVd6OEVrT2Z3d25rVldRMEk3bEV2ZExrY0VHTCtO?=
 =?utf-8?B?T0pxcVhCbmhkbG81VGhFc1lnOTZlK3ZzcDVmQXA4M003b2VDeXNQeFlLY2Vx?=
 =?utf-8?B?a0xWNlorSGFKMlNqTFVuQkE4NmJjWThwdUc5M1czeVVESkRQUS9sMVY5blo0?=
 =?utf-8?B?ZW9ocmRUMTh1aEx1WkNVa0w2dWNBUHNmbVFnYmhCbWx2N2k0ZjA1RktSUzFC?=
 =?utf-8?B?Rzg2Z00zdjFEWjhzczdQa3BOWTk2MmcrejVqRmhlM3BHeVFDNUMra2NjR2pn?=
 =?utf-8?B?RXJBOEFjZDRzOHpRZFc1T2RXbEFUT1liYTlYYTFrVVljWXdtZURVSkVFcG9G?=
 =?utf-8?B?dTNRVkZjOFMxeHRuN0pXZENBYlY2WFFxUHdTNUtXUTlhRG01MHpFUmZ3YWsw?=
 =?utf-8?B?bzhQR2granl6SkxKaGEzeG8wWktqdDFaU3BmUndMMkZkUVlib0RmYWxUVStP?=
 =?utf-8?B?NVZYRDhPMUJGcFE1VkpkWUNqdVhxY2dJYmxsVkVBczdqYVhQZWtpVGtGZDE4?=
 =?utf-8?B?ZzZQcldqM3NVRW5NN2l5V1BtK0lpNDN6WUI4cCtYMGVTYkwrR1NUTzJ0TTM3?=
 =?utf-8?B?VFpKS3BlYk9rU1BlNDhnY0tSSXp6MkxYMXhaeEpEK2pKbTFlRjg4SEcweXpS?=
 =?utf-8?B?RCtvc2NEQVVnWkFKYkFsSHVxRmoyb1N3Z0dqMkc4czF0eXdlZ3dHTVZMSFN5?=
 =?utf-8?B?Z3BnVnQrd2R0VHRoK2c5Z0tHYkhSV2gvVTZZRDEwT0xQUTc4MXgzdjFma0Iz?=
 =?utf-8?B?K0dNODQ5TG90bnJzNWhDT2FjWVNJYnpFSFNUOE1jcVBiUnk5aUoxeGh3WFVD?=
 =?utf-8?B?RVJCRlJYcDI1RHhYdS96N0RVdTZ2K3ljOTZsTjhoYTB3U0FQK3NCQTU0aDZy?=
 =?utf-8?B?dGxza1BUZnFPYUxLajdLL2NYU0FOYWJINEZKMUhWQXNFZGVYM3V6NWVmK2VN?=
 =?utf-8?B?NUxyY3ZJTkF1djh1YytUdHVRVHNoVjd4SnMwazVFUTZXWmhleS9iWUFoUm9q?=
 =?utf-8?B?YnRhc1ppMDRLdGlySklBQjN2OTZGbkxHOXE1ejRFdEgvQmVZUW11bjNGa0tO?=
 =?utf-8?B?QXJGaExJUjFmZGFJY1lJSitNcjBLb29LWGhHa0UwUktlZi9QSm9UZzNMVzVQ?=
 =?utf-8?B?Z1lsd3g3YURNdFBlL0R3M0tEOXExSk9hU3NhUE4xVm90cHhPY0ZKSDNFeExx?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b0e890-010e-4c62-f1d5-08dd6de6f1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:54:42.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixfSyYPsae4lf5ImN4AkmQMhp59kSRiTlJYIZCn3AHURUctDhI1pZB7wn8LBdc51C7B7BuCLGbsa1fTjpvyOP6EWwXiZYfpYxF1WYlja42M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8512

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDEwOjM5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDgvMThdIGNhbjogcmNhcl9j
YW5mZDogU2ltcGxpZnkgUkNBTkZEX0dBRkxDRkdfU0VUUk5DIG1hY3JvDQo+IA0KPiBPbiAyNi8w
My8yMDI1IGF0IDIxOjE5LCBCaWp1IERhcyB3cm90ZToNCj4gPiBUaGUgc2hpZnQgdmFsdWVzIGlu
IFJDQU5GRF9HQUZMQ0ZHX1NFVFJOQyBhcmUgZGljdGF0ZWQgYnkgdGhlIGZpZWxkIHdpZHRoOg0K
PiA+ICAgLSBSLUNhciBHZW40IHBhY2tzIDIgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5n
IGEgZmllbGQgd2lkdGgNCj4gPiAgICAgb2YgMTYgYml0cywNCj4gPiAgIC0gUi1DYXIgR2VuMyBw
YWNrcyB1cCB0byA0IHZhbHVlcyBpbiBhIDMyLWJpdCB3b3JkLCB1c2luZyBhIGZpZWxkDQo+ID4g
ICAgIHdpZHRoIG9mIDggYml0cy4NCj4gPg0KPiA+IEFkZCBybmNfZmllbGRfd2lkdGggdmFyaWFi
bGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB0byBoYW5kbGUNCj4gPiB0aGlzIGRpZmZl
cmVuY2UgYW5kIHNpbXBsaWZ5IHRoZSBzaGlmdCB2YWx1ZSBpbiBSQ0FORkRfR0FGTENGR19TRVRS
TkMNCj4gPiBtYWNybyBieSB1c2luZyBhIGZvcm11bGEgKDMyIC0gKG4gJSBybmNfc3RyaWRlICsg
MSkgKiBybmNfZmllbGRfd2lkdGgpLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHY2LT43Og0K
PiA+ICAqIENvbGxlY3RlZCB0YWcuDQo+ID4gdjUtPjY6DQo+ID4gICogUmVwbGFjZWQgUkNBTkZE
X1JOQ19QRVJfUkVHIG1hY3JvIHdpdGggcm5jX3N0cmlkZSB2YXJpYWJsZS4NCj4gPiAgKiBVcGRh
dGVkIGNvbW1pdCBkZXNjcmlwdGlvbg0KPiA+ICAqIERyb3BwZWQgdGhlIFJiIHRhZy4NCj4gPiB2
NToNCj4gPiAgKiBOZXcgcGF0Y2guDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYyB8IDYgKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9j
YW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2Fu
ZmQuYw0KPiA+IGluZGV4IDAwMDFjODA0M2MyNS4uNjJjZGUxZWZhMGMwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC04OSw3ICs4OSw3IEBADQo+ID4gIC8q
IFJTQ0ZEbkNGREdBRkxDRkcwIC8gUlNDRkRuR0FGTENGRzAgKi8gICNkZWZpbmUNCj4gPiBSQ0FO
RkRfR0FGTENGR19TRVRSTkMoZ3ByaXYsIG4sIHgpIFwNCj4gPiAgCSgoKHgpICYgKChncHJpdikt
PmluZm8tPm51bV9zdXBwb3J0ZWRfcnVsZXMgLSAxKSkgPDwgXA0KPiA+IC0JIChyZWdfZ2VuNChn
cHJpdiwgMTYsIDI0KSAtICgobikgJiAxKSAqIHJlZ19nZW40KGdwcml2LCAxNiwgOCkpKQ0KPiA+
ICsJICgzMiAtICgoKG4pICUgKGdwcml2KS0+aW5mby0+cm5jX3N0cmlkZSArIDEpICoNCj4gPiAr
KGdwcml2KS0+aW5mby0+cm5jX2ZpZWxkX3dpZHRoKSkpDQo+IA0KPiBJIGNhbiBub3QgZm9sbG93
IGhvdyB0aGlzIGlzIHRoZSBzYW1lLiBMZXQncyB0YWtlIHRoZSBnZW40IGFzIGFuIGV4YW1wbGUu
IEJlZm9yZToNCj4gDQo+ICAgKHJlZ19nZW40KGdwcml2LCAxNiwgMjQpIC0gKChuKSAmIDEpICog
cmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpID0NCj4gICAxNiAtICgobiAmIDEpICogMTYpDQo+IA0K
PiBTbywgScKgaGF2ZToNCj4gDQo+IAkgbglzaGlmdCB2YWx1ZQ0KPiAJLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IAkgMAkxNiAtICgoMCAmIDEpICogMTYpID0gMA0KPiAJIDEJ
MTYgLSAoKDEgJiAxKSAqIDE2KSA9IDE2DQo+IAkgMgkxNiAtICgoMiAmIDEpICogMTYpID0gMA0K
PiAJIDMJMTYgLSAoKDMgJiAxKSAqIDE2KSA9IDE2DQo+IAkgNAkxNiAtICgoNCAmIDEpICogMTYp
ID0gMA0KPiANCj4gQWZ0ZXI6DQo+IA0KPiAgICgzMiAtICgobiAlIHJuY19zdHJpZGUgKyAxKSkg
KiBybmNfZmllbGRfd2lkdGgpID0NCg0KMzIgLSAobiAlIHJuY19zdHJpZGUpICsgMSA9DQo+ICAg
MzIgLSAoKG4gJSAoMiArIDEpKSAqIDE2KSA9DQoNCg0KPiAgIDMyIC0gKChuICUgMykgKiAxNikN
CiAzMiAtICgobiAlIDIpICsgMSkpICogMTYpID0NCg0KPiANCj4gCSBuCXNoaWZ0IHZhbHVlDQo+
IAktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gCSAwCTMyIC0gKCgwICUgMykg
KiAxNikgPSAzMg0KPiAJIDEJMzIgLSAoKDEgJSAzKSAqIDE2KSA9IDE2DQo+IAkgMgkzMiAtICgo
MiAlIDMpICogMTYpID0gMA0KPiAJIDMJMzIgLSAoKDMgJSAzKSAqIDE2KSA9IDMyDQo+IAkgNAkz
MiAtICgoNCAlIDMpICogMTYpID0gMTYNCj4gDQo+IElzIHRoZXJlIHNvbWV0aGluZyB3cm9uZyBp
biBteSBjYWxjdWxhdGlvbj8gV2hhdCBhbSBJwqBtaXNzaW5nPw0KDQowCTMyIC0gKCgwICUgMikg
KyAxKSAqIDE2KSA9IDE2DQoxCTMyIC0gKCgxICUgMikgKyAxKSAqIDE2KSA9IDANCg0KPiANCj4g
DQo+IE1vcmUgZ2VuZXJhbGx5LCBpdCBpcyByZWFsbHkgaGFyZCB0byByZXZpZXcgYW5kIHVuZGVy
c3RhbmQgd2hhdCB0aGlzIG1hY3JvIGRvZXMuDQoNCk1hY3JvIGlzIGRvaW5nIGEgc2ltcGxlIGNh
bGN1bGF0aW9uLg0KDQooMzIgLSAobiAlIHJuY19zdHJpZGUgKyAxKSAqIHJuY19maWVsZF93aWR0
aCkNCg0KDQo+IA0KPiBDYW4gYWRkIG9uZSBtb3JlIHBhdGNoOg0KPiANCj4gICBjYW46IHJjYXJf
Y2FuZmQ6IHR1cm4gUkNBTkZEX0dBRkxDRkdfU0VUUk5DIGludG8gYSBmdW5jdGlvbg0KPiANCj4g
YW5kIHRoZW4gYXBwbHkgeW91ciBjaGFuZ2U/DQo+IA0KPiBJIGRvIG5vdCBzZWUgdGhlIHJlYXNv
biB3aHkgdGhpcyBuZWVkcyB0byBiZSBhIG1hY3JvLiBJZiB5b3UgbWFrZSB0aGlzIGEgZnVuY3Rp
b24sIGF0IGxlYXN0LCBpdCB3aWxsDQo+IGJlIGVhc2llciB0byBmb2xsb3cgd2hhdCBpcyBnb2lu
ZyBvbiBhbmQgdGhlIGNvbXBpbGVyIG9wdGltaXplciB3aWxsIGlubGluZSBpdCBhbnl3YXkgc28g
eW91IHNob3VsZA0KPiBub3QgZ2V0IGFueSBwZW5hbHR5Lg0KDQpJIGFtIGxlYXZpbmcgTWFyYywg
R2VlcnQgdG8gcHJvdmlkZSB0aGVpciBmZWVkYmFjayBvbiB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1
DQo=

