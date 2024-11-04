Return-Path: <linux-can+bounces-1873-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A959BB91E
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541E3B20F20
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430771BF804;
	Mon,  4 Nov 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="dw6OJk43"
X-Original-To: linux-can@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022099.outbound.protection.outlook.com [40.107.149.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9D13C827
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734766; cv=fail; b=Gw5yIwOrN3437KExAOGGpu2G8sxL4ZEQ9izYQS8oYvZBphEZ3N9ufAEQetZG4fhuuBkPCgSoRqRnFUZ5Wi6T7HclLzQOY5fFa9/nZzMZxqT6BgzXzhxxLsZyagmriZoWpqKDXX9jbMze4q43EiUN7zgXarZFYsogbHsSsfcU0Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734766; c=relaxed/simple;
	bh=Tvoa8PiBsvfGp3hls86uhVNM2gpoFL1RbToXDbGAnDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6M1gM/hZcw2vIDOop3hukiIr97TxzP9Hn2K5Z1wkKxQ4hZYw+wYUeDk0SaiOmt5B8s8OkL7SttmzDMdGcN+oXLmpdFD2mirsx9BI6N/apIjQH/Bqz8FrDeFoYfV0JkkmeGUy26+JAfXrUjhhKp8uiNZ0EOK4w+Ga44um6QOySA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=dw6OJk43; arc=fail smtp.client-ip=40.107.149.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEdE0rJQ0kc74eSp/NpwOyh9TYYLzneabixV8icU4x5Ba4Kqsw1lT5JVhe8yn38ajf2HwQyJC/RefHtN36XRBva7PPPeKbf4TUsCLVuv8dHOLP9kZ1Bl8mCI7aKRJLRXlFK5pk2PQCT+h2EgDQLxo7zh67g6rfNH/uLHJEuprHPXOW7JqYKQzKmqhOqLFv1Fyhvi50hCWlEi8gOOE0h20e0t2j0ckMpPJ8EeDsg5XlSE9r3T8K0tgoyyEv00Dszq4H0d5U7h/XU3Nl1MRYPICLKfzf7F0TyF4Eb9M0C0xUfe0cjCqvWHiGxDbXysJp8ZcuxRRD4zFydteDw8RmGjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99sHCgecZWD92mQGBzz2do9BHxfv2KCmRWwCCVPPv4c=;
 b=m7fX5zckzmtUiLF6BxtqDCfBjYwgwGSnbZ7ev41O+h2Ibem+gZysRLAN4EO6py2EC3tQgxqssm8HB7b8B663FuFDIYg6lyhDX5LIpBY4cwici/npIvOiqmcog0c82EmIKDAzRkwX5tuXcPtZ/sP/Qp3RzzDIX5oGnNUXblWAXSDsCfITJ1/5ivqwbczARz/OunHf7+nhGCOstyQS9kgqY48qahdvXPlu8zTE6g6oNUQHoSpxZa8xzYS0o186qFpR/QU9KlMgzysmlpZ0m3iUvUBA77f2DYsbZwr4L2TYnnwzJGOtRcen8WHeafrrpRVXnL260HUGiTziSAuJmMZlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99sHCgecZWD92mQGBzz2do9BHxfv2KCmRWwCCVPPv4c=;
 b=dw6OJk43BdRFAH91PNEutlWuADZK8rwhDnfXWpybTv4jsfnI9jBLuBewvpxNTYtKFYrQkR0p33wkc6en2shuwy99UdIr6E9h3161nDJToRiN4VkLWMJJwvm3YOnRZnLsXgS+mJCo1onKH41B0zcla6EBHGePww4ojLhUdgBa6bQ=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BEVP281MB3521.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 15:39:19 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:39:19 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp
	<thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: AW: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Thread-Topic: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Thread-Index: AQHbJsReg/Ty+zMwvECtW4DULiPQ0rKXnUtWgA+RiICAACJ27Q==
Date: Mon, 4 Nov 2024 15:39:18 +0000
Message-ID:
 <BEZP281MB2245C60193FDB044567DAB75D9512@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de>
 <BEZP281MB2245A3077CC6306F78C623AAD94F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
In-Reply-To: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BEVP281MB3521:EE_
x-ms-office365-filtering-correlation-id: 372c8b8d-85c6-45ff-b48e-08dcfce6d8c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RsWErRxuazTZRAOfslDAWdQnBJ28CR372UYzhga/kuhl01GdEc3gGXU0yP?=
 =?iso-8859-1?Q?W3q0z/5zUYpQ3dCfF/FKDTk+v/LKp4Su9KXh/vx1g2EAN7hGf0LimXayIu?=
 =?iso-8859-1?Q?c+1g4xVDDYBkdE3NQFPJAAsaW+RN4iD0ttk3QHkoklncr9oNWD1wlZn+mw?=
 =?iso-8859-1?Q?vZdI5F4ZJPfzLbiVzQ85dwdMDa19Uyw/DeyX4hISdIdUmHNs7gVx3izRMy?=
 =?iso-8859-1?Q?sJ3KBo8gWwG5QQv6jrx2IceKgORxZxh3Afo+0fflZv3mVfUxeUS+Bsn8cJ?=
 =?iso-8859-1?Q?mtMih8oVUaBIDp9PKvbAWxdbpAGzVocBTlQ0frnq7Xy2r6VJpK7N4GOlPK?=
 =?iso-8859-1?Q?Hmm/v4i2bUxaxLCVCDC/E/sXyAt08jLZ/Ds4pHpr7lFiT3nGQ0jl43DF8X?=
 =?iso-8859-1?Q?3jnybD5HQ+wgh4QEh4KIYKBoi5yTUWbHbovcaOeM1TWasmpmttAQ/BI+ay?=
 =?iso-8859-1?Q?JvORj1jCQa1cUQD5RoJk0xsxZwEhZcIO0ub3GApsIanOpSS15rLAUVKqWt?=
 =?iso-8859-1?Q?OUij1B+DhjbYXpIOBcTVAiPZBPJtVCSFXALjA1k512GvuJpEzK874J9Ju+?=
 =?iso-8859-1?Q?ZpDqPGj+Lehjw+6P4SoU9Zdfc8vUiQqo0YKYbanRCLPtuYUcCTYeJNDb0Q?=
 =?iso-8859-1?Q?sPPVVTMkx4HigU6edpDVDRqn0LPHEPEEAf5EmWrJfWjtRLM3UEogXzG0Nz?=
 =?iso-8859-1?Q?VgWRNYB8VPPyB6pn3FzQa/6BdlMaaH5hdDs+2BAw8pAbv3Tq5utxKDYlY9?=
 =?iso-8859-1?Q?PkyO3dxJ8GQuzCumrIX5/+p6p/CrJ03Tu5HDXwRVHXDv0pxmQONn052ZKC?=
 =?iso-8859-1?Q?hqnpaH5FDtfMn7rZVTGyhAl80Q+e3TGOgN8KjLmRX4lLhQRtIlygfUBS7v?=
 =?iso-8859-1?Q?0WP6FCFznOLiWDNPIYpyLrg2TgiZCN5Fjyrj2d3zg912rZLCS6I/dGZ8Gi?=
 =?iso-8859-1?Q?xzaIsYBxmxSo/XKwsbR4fI5VVf92PiIJVIRX/rkOd4vLyHFacz14+jZERB?=
 =?iso-8859-1?Q?1F+xXi5TQ4DMkXtPnOetKGUsMZ6aTdQA148IYxR8+S5m0cFD86QHWnJA0B?=
 =?iso-8859-1?Q?6MK1/QrnJ+TpJuiMa5JLZCL+MPsgJ6m8L3YsRS+lIRuG53yoNvStmH75R0?=
 =?iso-8859-1?Q?rGAzneON3SxK18fTTdcyqYiqknNGP+AiBqUgdbYipjV29gSu7fKfvs3XNb?=
 =?iso-8859-1?Q?MkoasRFte5q4nyjPyddeDTN26TfDqVXyeW6P4LyTzneY5Su5hK7TmSCiUl?=
 =?iso-8859-1?Q?OrVMp68+IDBKUBFpneqbsgT+YUGiGbr/fgjjufdyv6e4Ww7Mp3w8z7wNXj?=
 =?iso-8859-1?Q?ZrVRSD1R+qIlRB0sTm2EpS5wuGqWlLmiB+6RUi8FzXGS4vflIgpFgoyTSv?=
 =?iso-8859-1?Q?scqyqbO0sBuGD7QqrXE6tEt4s8JGwtFLiIKikae/yq3d4Iymujr4w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YptFkYwoA4WhSU39c3CaI4/EA2AGi+dJ6K0ynssXzqgyNngcwpZNJTuDI8?=
 =?iso-8859-1?Q?66Pb/U4l4FJ5MXy2l7u24nISIzSVyomb11u9jEaHKIpqkXRBh8VvSc2qji?=
 =?iso-8859-1?Q?NhKwa0CfZEsgr55+O9H72EbPynbBqH5v7IGypFDv0NNbPedGL6/Cs3/dIf?=
 =?iso-8859-1?Q?TF8HwOxIsFPyCtrFDlBxFPdhDWOUgKYqhEU4Rc69eW+nd+qiM9xy03Vz9t?=
 =?iso-8859-1?Q?DCQ7xe6dTAkIILyU5vlemb5fDV1y1fp1QMe1I1p5tz63XEL5wtc+LiX+xw?=
 =?iso-8859-1?Q?kmrcv5DUC09z2BPpWZso2RO92E6/MSLr2kev/9xc48Qo4wJ7WhpwG1DNWo?=
 =?iso-8859-1?Q?CSVyK1D0efKR2ygZywGOur+qsOcZT/BhUaqELdGOH3zPiPWRCdM2TNAEZ4?=
 =?iso-8859-1?Q?H9J0H3Ancwe8xQBAlwd9O991qaj0Bmj+xZn9jZ9Rp+QCkyhTI64BArav2z?=
 =?iso-8859-1?Q?OszUXE2X0WaDigRvSDtzTm5+n4T+OkJItAGIAYL+AYYNRZmeakIlnPaPg/?=
 =?iso-8859-1?Q?7HNIApxVD7q4MzAXpeXsYPInWf/RrRjOA3MotftvDSEal6VK89AHUhhPhZ?=
 =?iso-8859-1?Q?7I9sFK0RyYe1kSR4MsdEZFvM6gJUpW1cEi97U60+PU+gpNkt/4glO3fR3S?=
 =?iso-8859-1?Q?aGzTkSV7hHsTGUOav0QieyOXMuMsqHE1YUMgjcinyFc+xhj5m1yhSn0yf0?=
 =?iso-8859-1?Q?A2rjivTfO20niIzIlQrbJb9beYZWu10FQ9AMFP2ISyfBvijsVEsKvZaBcr?=
 =?iso-8859-1?Q?0xKAp4UqTTXFPi5cDIDtB9Bo0OYt0r66wY+Emq9rTqVkkcBtKOUAL4EYev?=
 =?iso-8859-1?Q?ImdISuKX+5SMj2r++NAukwy2UDd0d42WbgmSQRIQq9eUGpCp4wqxQ7O3SY?=
 =?iso-8859-1?Q?579zyXBa57TrF2jRGKVbs1CeCniJSbxtm4gndimE2TVbNSPjwmc+a4Ug+I?=
 =?iso-8859-1?Q?HhpVOgAA2S7rP4Pu78N7YKjOnCKJYWNCOhYkO/kW15hIcxSwtDFScFOd86?=
 =?iso-8859-1?Q?znfG4p+hsZVd4sPpRtPeta2FmldOoL9Aq5EnF8xXpeHPotLH5q8m8r0GhS?=
 =?iso-8859-1?Q?gptoA8EwqcE7tyT8fgEHuVn/l5BjLjbRAMu1Lx6Sju85dIEsB8wcWoDRij?=
 =?iso-8859-1?Q?Egot75m3KEdW+hylTI3mJYfqZCnO1aTkNQrN6z9Ev3vY1O90d8ipSyqlLT?=
 =?iso-8859-1?Q?nweJa4QF+a61y2UK8dwrYEiJBX26/PjwWSXgPrUiz3w0hWwMIYrIcppBKd?=
 =?iso-8859-1?Q?+EiD54j3IZ5vdRBIFldVjqQG4VNTt0CD7OPFpV0FsgwPBM7XriOYA3mQ30?=
 =?iso-8859-1?Q?TWWP1WuJO7kkuVmaXhbXnMU46NsvDFufX6R+TUbPBGW6x3hAdwoiwpM9xy?=
 =?iso-8859-1?Q?SATpWkUy9m1/jq0OmjCw3xShMoCCDS6GJ7pLlXckoKoCXhm6KMtSr0UQl0?=
 =?iso-8859-1?Q?7AfaQ+PvZLZWyJ9OX/oHgxW4muM4sPV1vGVGpVsgN3plNqpgLGwa77Qe7U?=
 =?iso-8859-1?Q?CxSwtqKJPyp9zPW3dw6TE6EipVaqHjZXiV2rF9ikmxontuYgpnzQJC1U6m?=
 =?iso-8859-1?Q?oqBC9h6YsK2KXwoPEkg04CL36AaX2rAJQdV8/gd3r94sH6GbADw+35QcKN?=
 =?iso-8859-1?Q?NjG2dBGadjyFVK7F5PXqmX02JQIFtyORzjoa+4Qdz4baab8zOCDVersA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 372c8b8d-85c6-45ff-b48e-08dcfce6d8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 15:39:18.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VAC1FSkDs0WJsemCJBtZzWo8ESsbHxImaErKAy1mf/Bjvpz3ovIBvXX7D/e3mJOWj42FgOpYMDGRvBZdlez45XQgoT3KXdgRz9cn2B913s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3521

Von:=A0Marc Kleine-Budde=0A=
Gesendet:=A0Montag, 04. November 2024 14:33=0A=
=0A=
> > On 25.10.2024 15:50:37, Sven Schuchmann wrote:=0A=
> =0A=
> > this looks good to me!=0A=
> > I have no crashes here anymore.=0A=
=0A=
> Thanks, can I interpret this as a Tested-by: and add it to the patch?=0A=
=0A=
Yes, you can add Tested-by: from me=0A=
=0A=
Regards,=0A=
=0A=
   Sven=

