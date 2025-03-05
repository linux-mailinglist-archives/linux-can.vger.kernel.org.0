Return-Path: <linux-can+bounces-2982-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4040DA50078
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A463ADFEC
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA72459C0;
	Wed,  5 Mar 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="T+V3Wh32"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011033.outbound.protection.outlook.com [40.107.74.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DA24633D;
	Wed,  5 Mar 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180801; cv=fail; b=C4DNF5u6EqCaz11H2v3CqGMzMt/8xHHtrVZp+7N8iVxpB/LVwBcPXA0hlKNc5EBNfTJZidzLWi7/Zsux9et/daVbx1sYehZQesebSb46irrbKvjiMw8XtiNgTHFezPiPdY66SP29FY42bA5WNeGDyrPj2ij87LOLxNLFqT9gR8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180801; c=relaxed/simple;
	bh=jmryORn9Jtpc8Je/5cQS05dc4aFI7V0+9qzEOlDk+jE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ddopd+EFyFpYCGkW/TDojgNqe/+bsacRCFpSYovr5Y45k1E8Vtball3Yyvfcz4Cp5MK4Uxwr3+Cw2Ubmj+xH5Skkq7yHn2vxXLQaxrHPyUgSuQm5Mh5+K1c/jcXpEt66XthP0AbK+DHMOJ4H/ryB/prsyk3oM7uY3UlTk92CVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=T+V3Wh32; arc=fail smtp.client-ip=40.107.74.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqtUX+OX/IU32heI3UeDPrvrxzoCToxJsSfXqiC0q4VWgh76vLczH7m3RElPQTdobrd5o8GUIFF9BJ2asxtC4t6mIh9aTm6q8dhkcdjEKhQItgC0QBUo8e/pgl6vZByONRHfWABncpD6O+bA2YaXzIVREXdJByi+Ab2TGtGcdxBYc7hO5S0beO6eFHzpVng+8JEnU3XB8On43P37uUcGoKpcLGxHVyhzDkMx4hDENPQDyrx9W6nkE333fz/99nG/zd6SfOrG+TDEjogxIGDcx0ziZ4croTvmdOjBtSmgskKrR755E1a1zzg6t04G8GyD0oj1GqYETmiBlSUKdVvHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmryORn9Jtpc8Je/5cQS05dc4aFI7V0+9qzEOlDk+jE=;
 b=NSyUtNjwSx9rvYw2f7WFoN6LdY1XYLO+iW6YFb3UnZIgk3s7GVxhKK9k80XRMLrlJptLcboH6C965BQnxulmIxKsNbegoq1S1d5WgaENjxXKdSQhu/hccFZFzhb8Yd/ezsY9KgHtfnR5JSP6VuZT6iXWrGOvxIt4U4Ifm4SDM7TmEYi7zZ0oeoc7Ion9hhOYQJk+Uv16VPca9EDh6baGFkPQfNPOsYtCf68AtDJUrxZm6eWdbtNizTLMRtBXiWBZeO+bvQlMjggcYkDgat+Umz6oI1DbnbvS9NRGmP1oQSbGJ264MY4LQIgFxaCEHhtmtLpmyGNaMMrzAb6hOfDCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmryORn9Jtpc8Je/5cQS05dc4aFI7V0+9qzEOlDk+jE=;
 b=T+V3Wh3266Jt3WI9HSzsePRuymz8HWwZN8OT1EFnKFaPgJGZoWDNzfKRMD8jr3zccbmmuA1GahDIRRPmQTcPuU0wSIJh2o64Up7ULkDXa2Q93gg5JDVs/nvVVHgt0gJ+DlIkJu4g7DxiD54Ql9xUgtX83iHmM9af4TVdJ/M9FOM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:19:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:19:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v3 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbh5vCfD7+MsknyUiTfjfER/rrxrNYKwOAgAxoRHA=
Date: Wed, 5 Mar 2025 13:19:56 +0000
Message-ID:
 <TY3PR01MB11346EB14519C580F83BB08FC86CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-9-biju.das.jz@bp.renesas.com>
 <20250225-piquant-spiked-mouflon-3e88ac-mkl@pengutronix.de>
In-Reply-To: <20250225-piquant-spiked-mouflon-3e88ac-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: c465662e-3d46-49c5-bab5-08dd5be86c8c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUlTTnBBeVdSMytPTzBoN3FDME5XUEl4ZTAvZFdyRzJieWVWY2ZZaHh5TDZk?=
 =?utf-8?B?YzJvQkdyc0lWdnMzSHNFQ3YrL3ltcXZFVm1UeUxtZElLejJWZ09qd2t4b0h1?=
 =?utf-8?B?MlpIem5MYjg5aTdBK2tJTEhuRUsyVktOTUNnQTFqY29NL2tsdXQ5UWlHNUtW?=
 =?utf-8?B?U09aV0lWd3poNmtBdVdBU1YzRmlSdVhUY2ZCdjBuUm1PYS8xZ0tLOElRQWg1?=
 =?utf-8?B?TkJDSkxJUnREYUtXaitXd09xOEozQjNiampYbEVZNUJISVQ4cndUcmJsVHFh?=
 =?utf-8?B?RHIwS2FhV0FIUVZCN3g5QnhKb3FIK3hiKzNMOHRDUEtqL1o1ZGdOWGZOWUs3?=
 =?utf-8?B?OUtkY2taMmdlejFsUW5RQ0ptbkVuZ2g2enBaQXorL1VFY3piY3FmTjJHYnlF?=
 =?utf-8?B?UEJxNGZyQWZPOExYb2FmRW5hOWh3QmRXNm9Gbkl1UVhhMHVPN1p1MFM2R1N6?=
 =?utf-8?B?akpnblkyRWlrbEdGSHRLTkc3Q3lKbG02dnpRdWdiYUVsbkhkeDlwbUc3MUh3?=
 =?utf-8?B?elpBbTVNeHZrRlduckNIZE1NUGF5OGZ4Tk1QekdkaGtSVWJ2OEhZUk83RlBL?=
 =?utf-8?B?K0ZzYURqMFl4VGM4VjRQUEZLcjN4ZkxORThvRDZxbmFpRlpDOUhTSXJXb3ha?=
 =?utf-8?B?SDVhcjFreG1zb3JieG1UODd0ZkxVeFRtK0hMR0VQUE9Xa004a2VlMTBXdlRk?=
 =?utf-8?B?Z1liWU1sd3RDaENlaThWdEx2azR0c2IzMlRtV2JmeDYwNnkwYmU2dUxNZVdo?=
 =?utf-8?B?R3htTTlXa1dvM01BTzJmZlE4YmhtcnNBcnczZTJvQlpaN3BCRWwvVmZLdGhs?=
 =?utf-8?B?RlpSbVZPUFdEbXl4TC95ZjA2aktLOHU0ZWM3YUpOdFFFRlVLQXJRYUFpOWsy?=
 =?utf-8?B?bzNWT3FySWRwNTVOUlIrUE82N1IvY2pxTUdJVnJ1RnQ2TGpzSU14aE45N3Rp?=
 =?utf-8?B?dFFwNVppM0JtZkY2K2dZZlYzVlVvbVVZN1dWWkJhaTBLUDE4Y3ZYMERheWlU?=
 =?utf-8?B?bjJ5L2dZY1ozVUtIbXoyVElRODNwZlNhYnJDTU9VR2Z2NnpTcWtZRUF0YmEw?=
 =?utf-8?B?Q2FmNzNDeXlNYlcwK3pDSHZON3dVVGdubXJjZXgwVjRxc29BNnpldkpQTW5O?=
 =?utf-8?B?YjlaTjZ1L3hraXNKeWw5TVdpSnNRWCthbFZGdG9zdXNSTGxyaExvRDZTQncv?=
 =?utf-8?B?M1g2NERGaG5xMTB5Zm1iTlJ4S0hqWEx4SHVqZ3lBSFY4T3lLc1Z4ZGJ1NXFx?=
 =?utf-8?B?eEtiR1R1RnF1YTQycVBJU01ldndpcTl2MXIyM0VnVGVKNHkxekQrKy9MOXBm?=
 =?utf-8?B?RnZtaDZSMEd2RTA1anh3bDZzRzBtQVV1MlZzd2ZSUFdBWVcvOHpiMm11N2NT?=
 =?utf-8?B?Vmp0Ukl4SjVYcnEwaWhpbjN0amNHQnlGTU9aYXJkWHo4NURoZUhHeTVqM3ZD?=
 =?utf-8?B?TDZxL0hYZC8ya3ZYb3ZHNmk5OW1reVUrdUg1K3RoeGhBYXo5Uy82aGF1YVpC?=
 =?utf-8?B?N3ErYTNmT0RLUm9PWnoxRWF6SlJMZDZzdlBpd01rUUJCT1Rzb1ZibkJhQis3?=
 =?utf-8?B?UnIveURTWDBYR2IvV0d1Ylo5ZXYwbWpYcmxOdmpvVWc0aVl1QkNXeXZaS1hr?=
 =?utf-8?B?TWJxNStUUkdOSVNoTEJ4TFRZZG9nWHJBV29NQ0xjMEdybWxKaTVhT25GRGtQ?=
 =?utf-8?B?YkFVSDJhbE1KZzh2N08vdDJ6cVg4Zmxydm5RVnpIMDJWaHE4WENuUjhQWGgw?=
 =?utf-8?B?TkJHcGZ1K3A3YVYzamdLem5WOUNrN0p2cGR3eXVDOVBTQkFKVU5KK3dja2FY?=
 =?utf-8?B?bzl3YmdFa1l5Z0doVTY1THJlL21hVHA0Zk1HTW5sejlxRldqQ1JLWXo4bUox?=
 =?utf-8?B?bGZ3TFBpaFBWQUZORDNHcElxWkpQRUZMZVJreFBZTlRyUlplTW4xMFhmYUli?=
 =?utf-8?Q?8m1WXYTpMrQ/gYOVHnYm52kkIH/Q9MDj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1FQWGJHNkQzMTByZjg5b3VFYjZTNW52dWsreGsyL2pPWmY3Tkt4ZTRUcTJz?=
 =?utf-8?B?aFFrN3VIUEs3c3VaR1dRYzdybkxkWGxpSUdHOFRFWDMwaDhab0lIM0VZaS9a?=
 =?utf-8?B?azN3bzd4M0NXMERHOTBvM3E2cHkySWZnK0xZdjdvK0xHQUNGOExaYVltYnVz?=
 =?utf-8?B?S2txcXQrSXNrL25VNnhRektYZlYzU3hncXhubys1L0FPdEczRTNNZEVmUGht?=
 =?utf-8?B?UHVOK01UN3VIRmNlcGdVSzRjNllSMUpYRGlKcGk0OWhmbUNXM0E5Y2thTDYr?=
 =?utf-8?B?b3ZaQVh2bGJrOHhUa043eGJTN1RUWEJZU2IvWGZReTdSTnNpV2pZUzBiL3lj?=
 =?utf-8?B?VG4yYWtnZ2xUOUpIL2lMYVlXUGJoRkdRYWFobnFhK2l2bWwzaVVlTnkyS3BM?=
 =?utf-8?B?U09FeENFYnB0NXE1azIxVnN2SXhDUlNFY05PRjljcS9qbC93NWpuUFkwek1H?=
 =?utf-8?B?UWNDSzV1Z1dtVktwZVJYaTZrdXZvTHJML21uRU9YejNQdGJxNUtaT21LeE9j?=
 =?utf-8?B?OURjVEdnK2pIWEpMU1p4akk3UnB3WWxYVWtBSDRBTWEwSWFKWkRrSkhsSVBW?=
 =?utf-8?B?cDJwTDJZYzYrNlJFVytaTldWTXVLMUNMS0Y4eFNvdmdwSWJsZzZieVB3dDh3?=
 =?utf-8?B?ME53ZTFrbzJFYzgwa0MvZkxCdE5xWFEvdHByQWFWWnNud1BBNnkrUmlQMWJt?=
 =?utf-8?B?Z0MxY0g0bXVtdkxQa3lpaUJGVS9HcUs5Q0FVOE55Mk5vOFVrQTlFdmJpdldx?=
 =?utf-8?B?TC9aOSswYy9EZk1oM0lIZUgyN2ZaK0xJR0pVcG82YXpzVzFCVDV2OHJlZTIw?=
 =?utf-8?B?Q3lyMWdWRHFTRVV6OWpRS3lub3Y5UkVSSjFuTTlzVUo3K3IzQk14eFNBaDFs?=
 =?utf-8?B?OGhLRFgvNW9LWW9qc01VWTZpQWZyQ0c4dzg3YUs2djk3dEFjOXp6bkVKdnQ4?=
 =?utf-8?B?OUgwNURzSTM4eHM3aVI1QWVLZDJaN2pvbmowSmpHazQwYXpGSnJYYS9BYVJQ?=
 =?utf-8?B?ZC93SnpYazZNbXBTN3ZUL3FSYkdFR1lPdEJ4Mlg0bHFmYjliNXlQeTg0MzE4?=
 =?utf-8?B?bU9pSXJmNVdMWGZPTVZiUWFRcFBMbENoUUR1KzMrcTRjYnpUYWd3enBsUHUr?=
 =?utf-8?B?OTZLLzUwcEpiM2RrZlhpcXBJdU9XeTVBbm52ZWpvZ0tBYkhqeGxlQWk0UjY2?=
 =?utf-8?B?bnVXV2NGbThUMmZtSDFpb2YvR3pJVU9hUlBIOW5zN3pFeEJQOVJib09BZjdr?=
 =?utf-8?B?MzliVllicDdDcE1vdWI5TnEwTEljWEFZOTdSRmhkY0hPOTEzeGdDYmp1V0M1?=
 =?utf-8?B?UjMrSGxaRzZ2ZkNaTzh3QmFEZlpTL0xia2tDODN6RWJRMjdBeHc2NDVBb2xE?=
 =?utf-8?B?L2N4Tm95bDhjWEtxK2JtREJkQXNlZDd1c1V3Q2x0eGx3dWhpMEk2Unp5UStV?=
 =?utf-8?B?Wm1KcU1FN254UFpLTmlVY3hocTAvcE40RnBmdU5PdVFxRGlXNVdFOXZlcysw?=
 =?utf-8?B?WFBkL3ZHQnNTWmxoSnR1UUJTa0dPMUZRdFhIYXU1MnJ6YXUvTlZBVDdrbERC?=
 =?utf-8?B?VlgwR1FGb1JKQk1lWHVhZW0xb3FXcHRjTGE3blh3bkErZEZzSDUyWmdJcGR0?=
 =?utf-8?B?NHBaSm1VN1YzQkV6cVM0Vld3bkR3TVpQTEhCUkxqN20zeVdmTDYyQUFqMXFw?=
 =?utf-8?B?Ny85SVUwZ2hRN1lLMExMemhVbktwSmUzUkpHb3YrUEVuQ2MrYUFtdVR5b0Z2?=
 =?utf-8?B?VVRhQWFVNnBBRDQvd25xSDFobnpvK256aGJYR2lOdmgzL2xpeFNZblhWS1Zs?=
 =?utf-8?B?RGhjenlrTDlnaGIxTC9pOXJNQThYZllJM0dWU2s3STJXd3cvYytBNW9XbnZN?=
 =?utf-8?B?NU1jZ1FPMU53elRBcnNmNm9MSFQ4T0hQTVg1YTM0RnNaWG5weG13Yk1KNUdK?=
 =?utf-8?B?VytCSHRVTXBnRWZyaHRzbWhZYzRZU0t1ZU9TVEFnT2U4UHlJWFpNdVpTOWpZ?=
 =?utf-8?B?U2M2Uk1pdTVWZjBsejI0MjlvTEtKMzBGTDVpbDBhZ2ZMb2dMN00zcVZVMnVu?=
 =?utf-8?B?endDQm9PVTAyY09XVnFSaWRWVDBlTDV6WjNnT0pHNHdla0tkbHBVZVd4cTVG?=
 =?utf-8?B?TWdYQkdtWUs4alZreWZkZGZwQW9jZmtNNkw4ZTlXZDk5OFJLNVpMeTB0S00x?=
 =?utf-8?B?dlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c465662e-3d46-49c5-bab5-08dd5be86c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 13:19:56.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnvxeJLsza4Ja1ZuxlMZW6yog6aV7V53WX/JIWmrSShiTOsxlq62PqQXXdhr74DFmvCZnoqdgn95kkTXTnCxCUOEsUQWh8nJlkScaE1ZLX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyNSBGZWJydWFyeSAyMDI1
IDE1OjUxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDgvMTFdIGNhbjogcmNhcl9jYW5mZDog
QWRkIHNoaWZ0IHRhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IE9uIDI1
LjAyLjIwMjUgMTU6NDA6NDcsIEJpanUgRGFzIHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMgYW5kIEdl
bjQgaGFzIHNvbWUgZGlmZmVyZW5jZXMgaW4gdGhlIHNoaWZ0IGJpdHMuIEFkZCBhDQo+ID4gc2hp
ZnQgdGFibGUgdG8gaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2VzLiBBZnRlciB0aGlzIGRyb3AgdGhl
IHVudXNlZA0KPiA+IGZ1bmN0aW9ucyByZWdfZ2VuNCgpIGFuZCBpc19nZW40KCkuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
ID4gLS0tDQo+ID4gdjM6DQo+ID4gICogTmV3IHBhdGNoLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA3OA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3Jj
YXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4g
aW5kZXggZmNmNWNiOTNmNTdjLi4wOWE5ZTU0OGIwMjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3Jj
YXIvcmNhcl9jYW5mZC5jDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArZW51bSByY2FyX2NhbmZkX3No
aWZ0X2lkIHsNCj4gPiArCUZJUlNUX1JOQ19TSCwJLyogUnVsZSBOdW1iZXIgZm9yIENoYW5uZWwg
eCAqLw0KPiA+ICsJU0VDT05EX1JOQ19TSCwJLyogUnVsZSBOdW1iZXIgZm9yIENoYW5uZWwgeCAr
IDEgKi8NCj4gPiArCU5UU0VHMl9TSCwJLyogTm9taW5hbCBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQg
MiBDb250cm9sICovDQo+ID4gKwlOVFNFRzFfU0gsCS8qIE5vbWluYWwgQml0IFJhdGUgVGltZSBT
ZWdtZW50IDEgQ29udHJvbCAqLw0KPiA+ICsJTlNKV19TSCwJLyogTm9taW5hbCBCaXQgUmF0ZSBS
ZXN5bmNocm9uaXphdGlvbiBKdW1wIFdpZHRoIENvbnRyb2wgKi8NCj4gPiArCURUU0VHMl9TSCwJ
LyogRGF0YSBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMiBDb250cm9sICovDQo+ID4gKwlEVFNFRzFf
U0gsCS8qIERhdGEgQml0IFJhdGUgVGltZSBTZWdtZW50IDEgQ29udHJvbCAqLw0KPiA+ICsJQ0ZU
TUxfU0gsCS8qIENvbW1vbiBGSUZPIFRYIE1lc3NhZ2UgQnVmZmVyIExpbmsgKi8NCj4gPiArCUNG
TV9TSCwJCS8qIENvbW1vbiBGSUZPIE1vZGUgKi8NCj4gPiArCUNGRENfU0gsCS8qIENvbW1vbiBG
SUZPIERlcHRoIENvbmZpZ3VyYXRpb24gKi8NCj4gPiArfTsNCj4gDQo+IFBsZWFzZSBhZGQgYSBj
b21tb24gcHJlZml4IHRvIHRoZSBlbnVtcywgaS5lLiBSQ0FORkRfLg0KDQpPSywgd2lsbCBmaXgg
dGhpcyBpbiBuZXh0IHZlcnNpb24uDQoNCkNoZWVycywNCkJpanUNCg==

