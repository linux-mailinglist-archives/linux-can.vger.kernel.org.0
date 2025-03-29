Return-Path: <linux-can+bounces-3295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C5A75667
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448A4170CD9
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569B1B424F;
	Sat, 29 Mar 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gBndhNlv"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010061.outbound.protection.outlook.com [52.101.229.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B0199E80;
	Sat, 29 Mar 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743254703; cv=fail; b=b4hmfHlXQcyAAyXvZshMSR0I29JPFPu/Au/Pt7Vw53APn49j19SxxNRgtEpATUY/SHFxDoeUjU06dwgb195ImthJsgWaOOsAoR5kE5fbHYm04rYYfnIq1D78cC68xooZKbYmnk4HNiLEMpEiLk5H+zdhK/ijH7jtwoqFTO7HMlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743254703; c=relaxed/simple;
	bh=cJfoLn/C6wSonaSQq0K0wz8faMY7D9z7YJVFjwjI4wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqZ9vmRbtfmFfg+m3jL9TWLc0IgA8aIkpLGDKYxd1Z6Dz5DEikyMzCAv0puKXwvcyvuQGQyfFz7hfylD72KyDiHb4tOn4jnVCOXSA8Pr62DCUW2LXBdIa754dPfEWhKmOsxSNtxQ9Fos7Ex+zIs9Ranm6fc765NGwjQ+XR4fpdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gBndhNlv; arc=fail smtp.client-ip=52.101.229.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scQXC9Nv3ClI3k7NgnLYf/LbIOyH+VgpYgWTbOkkeibwNQXDsbAFNIqUTow/x9nckd28z2nhjU955ftbHU4wd51OFaGe9oWxmpsXZqwBLTaPGHwwrbJ4Rd3b1y7R4DOI2QLJavb8oaLXCENCndAvrtE694k77ZQ+T4lmJlVVWcuzBUZZTb6zul0GEb48g6t7x/QgcZ+/eCqmHEuHIXYrcrFPmgtpJ9tB8Z5dkPpcm9zBReCMDXDczmtKhur1Wr2vFFde9ZFuSwiDO5n4J/hxhKotnJ4JoybC6cfZHU2PnkywsBaadlREEXsHn+eWh82kF6t7t5hUWxM0QJ14xDaWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJfoLn/C6wSonaSQq0K0wz8faMY7D9z7YJVFjwjI4wk=;
 b=Fn8Zv3UOvWQ6wyhJLjRe3Dh4CnPTrNlgwTw4TSZ3kpcGbGlf7W1spmBarBHRjU4UVAwWO95Zc//1bNVGPyT4AaYJCNncK+yuGGGOnOftWJcPls4Oymqy64QT/jOnRJEke3KvsV+x9OzCcLm4UK3/WZGLE8Dpp0oFnmRZoEazG/RCfCyybfjklK5P8XHwVNzh177mxL0tZ9uF7XkGI8yKqpyVSs2oN7he5TVtzLsEifgOvbcNMCz+bJh6ueuSP137R/4PN3XJSvkWMPvKA1nWyifcbTGZgb5+kWymvt1TWf2GRotiIUTGu+L/+twuc8RMj1cosn4zWvHIooeAuIm55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJfoLn/C6wSonaSQq0K0wz8faMY7D9z7YJVFjwjI4wk=;
 b=gBndhNlvY8n+n+/zECirctXk9jAQp+AWOlRRztycls2x4lpVi7lXBtf2Tjx6iW8Mvo9UnCPga523kx3Tnq9t0PQB8I2A1XTBEoCHiStLgRHbrmArZ0oWBCy97rTRhuKwOPAw65loBB2zv3Qj7YmcOf88WaTsQhpEgF2W0EcMcNw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15714.jpnprd01.prod.outlook.com (2603:1096:604:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Sat, 29 Mar
 2025 13:24:53 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.028; Sat, 29 Mar 2025
 13:24:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 16/18] can: rcar_canfd: Add only_internal_clks variable
 to struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 16/18] can: rcar_canfd: Add only_internal_clks
 variable to struct rcar_canfd_hw_info
Thread-Index: AQHbnkmQiSGALDKbU02eL4f+qKVFkbOIrxKAgAFoHDA=
Date: Sat, 29 Mar 2025 13:24:53 +0000
Message-ID:
 <TY3PR01MB11346DFE329DFD30A915E4DA486A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-17-biju.das.jz@bp.renesas.com>
 <1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr>
In-Reply-To: <1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15714:EE_
x-ms-office365-filtering-correlation-id: 880c1b4a-95fd-4fa6-db3a-08dd6ec5177a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFdmUTJ0QWNJaFFjTGNrcTVoeEpvVEJIUG91ZXRFTkNaWHJkaVBHTUxUYkZD?=
 =?utf-8?B?YUdIeVhqQzh6ckdMVGg4czdlMnhNYnN5aWRQYVZGU0hiRkVKanZaMmJXc0Yv?=
 =?utf-8?B?TmRyRVVLY09KWGNmenMzWmwvbGhFRi9qcTJ0NlRRUFFRN1pEMG84SE9JRFQ5?=
 =?utf-8?B?WW5uNk45ck13bEVuVlF6ZXI2bmlSRERCRmNJYmVnbm5BZURkRE54djlaay9W?=
 =?utf-8?B?TXc1U0tOK2RWcDlhdDQ3b3dqakxuT3NwMDZscG1xZlcxbmRVbFhjc2VnWkRr?=
 =?utf-8?B?ejVXaC80d2w2Y3dFNXNjUG1JMHJUemNpWGU4N0lhVXFodTlpZVRYVXAxeWZD?=
 =?utf-8?B?cHVUVVZ3K1JJNzBCbXJjRENuSDRUa0hrNURqVithYTlhRXpYZHJ4MmNSS25W?=
 =?utf-8?B?azNONlFNdmlhQUdWUXY4VkVSbmtlNnBWSHJRT25iOGdkU1lmcSt4M1ZxbDJ0?=
 =?utf-8?B?ZW0yZ0JyQ3N1d3QyMm5FelNMcG9tM2RWWnRrQXRHQ29zOTNWWDhLMW9iWXli?=
 =?utf-8?B?cGFEL3FFaUNNRkdRWXFPTlNtZDBWaGFUUlRtZ09LTjFRSFV5aHN1SUN6eUZU?=
 =?utf-8?B?UHNSNFNSZFhOa0tzTndYR3BUUGpybEdlREMrZGFIMmQyZXN2OU9MNUdISTU5?=
 =?utf-8?B?RzFuTHVLU0RqdExqdG9teVRvTmVrQzRwNjk4MHRHY0I0QTJBOTBjODdvREVB?=
 =?utf-8?B?K2dlRFZPUWgvaEcrK1Fla2V0RlRGV09lT05ncThEeXRDdzhxaURRaFp3alk0?=
 =?utf-8?B?RTFpYWZkcGtiRWk0Z2tNWHVZR3luR1lZRlFRN0lBa2t3S2gzMlpSSUs2VHBa?=
 =?utf-8?B?bFdzaEc0NmFnY0xld29ncjRmS1A2VGozeUs1d1RUVHBseWdPd3BublNPa25t?=
 =?utf-8?B?YzR1cGovNFc4SEVMNWE4N0hkTnhiYzlKS2NoWlVtbzZZc0RqcDFyV1Z6VXlL?=
 =?utf-8?B?Q2RjVi9xeHAzZ0lBVmtqaFBzMFlFeG5YSXVoOE1hcFpDQ0NQQ0FXTWxudndw?=
 =?utf-8?B?RWgxa3dFOUhGaFlid3psMnhkbC9JY3RseFR1UktpUFVmZ1pISjAxMGwvOTJX?=
 =?utf-8?B?ZzM1bVR2TCtWUjZNTk85MGRqQnlUTTkxc3VQM2I5dlJPb0dpRWNXaFNwMHZh?=
 =?utf-8?B?OENRYno5QmNGNHAzRDBXNFFVWnR0REtZMmtYaG01YmJ6aklpRGFLVDlqNXRs?=
 =?utf-8?B?ZFdSaGRWcmQ1SmtKT3FlM3c4clhhMGJhWE1vQ3FLQUZkM2pIMzdQbnhLTHM3?=
 =?utf-8?B?OVFCQTNUSGFtVCtVQXgxaGFsQnZvK0dVeGZ4MDBFN011VFVZZE9lZVJxdVBy?=
 =?utf-8?B?ZThBaysrNUE1NFRUNC9mT0poR2ZZWnZJY281UFBlSklMNHpyUEFtY2VzS09W?=
 =?utf-8?B?ODhxdUtvbkRjaXROVThubkFHWUVYdzR1UHRYdGk1eGRoVm1oZGhGWk45WXZF?=
 =?utf-8?B?b2pZVnpraVJreWZtd0dVZjY2OGQ3MUtvZEdyYTZvZE1NVzM1Qmsxc045dk1I?=
 =?utf-8?B?MWtEc3BQV1R4WWNCSzB6V3cySHdkeHlvdkpkWHQzZGVaYkcvMGVnNWYzOUE4?=
 =?utf-8?B?MjVhZXI5OUVEbzZ5bTE4dzhpK3k1S2hSTFRURStEbi9zVGt1YlRZd3ppUmdF?=
 =?utf-8?B?VEJ5U25kb2RrWm1kMUJXU0oxbXNjMXZXdlpIa2s5YTZGNm9xbVNYVlJMVE5U?=
 =?utf-8?B?YW45OGlnMWZER0xxZzgrSTdLWFVHZUtjWDhZVkVWYU5SYzVqdXpZeDdlMVR4?=
 =?utf-8?B?T204WmluRFZSdTY0cTFxZ2tpejFIbTFVUUNxVFdYSmVNNVpRUFVyYnpNWitm?=
 =?utf-8?B?N25rMkRNV0ZnVjk3cDd5MFovR2RtRGZFYVQxbHVqUkRSZFJ4TjJkcytmU2h2?=
 =?utf-8?B?Y0pMUzRzUlErQ25WbjNYb3J0TDZRbHo1ZElGZnYvWHk4M3ZKSERhd25pZy8r?=
 =?utf-8?Q?lbnFxL4nUNFhi+JvLf5K3zKn5NGR5L++?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TC9RR2s5ZmdSQ2tFRFlLa3B6SHY4Vzl6RFJjUzcxckNqcGRhbHRYTDl0emN5?=
 =?utf-8?B?WjhwcFhVMXdHY0VnSWZJSVpodFVwYVVuejhBTHdSSEdZWnRCMzNkNkRGT0xF?=
 =?utf-8?B?RjhSVWlJWVNzZ1RDYlpvNGx2YTNUUmRrUFBpM0YyZlRuNDdHMERZWUtLL0R4?=
 =?utf-8?B?eC9MTWcySWxsamFwTUIvNG8zQUs3YjVGazdvRDFXb1BlQjJ3bGxjQ2V0aWFM?=
 =?utf-8?B?Y2VUNXVXdy9QazlWYzN4QTdxL1JvN0hqY3hoS0xMTDZTUXlpbFFBdXRUSlFz?=
 =?utf-8?B?R29Mdjh2MUkwblZQN0tPMTNGWVp5YVcyM2c0SEQxSERnMWNCRm8xbnJoVXZ4?=
 =?utf-8?B?bTFaRFZnUmR2ZmdEVXFqVkplbGRxM1FEcHZSNzJqZEtKendxdGhHU0QvQzln?=
 =?utf-8?B?VG1QRE80Mk5UQXg0aWZPcERyWUxXeUVRc0hoS3ExT1R6ZXZ0V3B1dy9KeHhy?=
 =?utf-8?B?SEcwRTBKa0JyQ1UvdytrN3cyUndMekk2M1c1YnpWanNaNWp3M21uNjdqVmt3?=
 =?utf-8?B?VkxGWnBFR0RZcTBOd3NpemV0VWJ0TWZIZlVtODYxdE04bnpaRFU2eUF3aGZI?=
 =?utf-8?B?NHAyMm5haldkeU53bDNWbnRRVzdNWnh2N2pOSmU4ZkEyWmNTS3hZNmwxY3hh?=
 =?utf-8?B?VEFSa2hUdGtWM0tnMXplSVpBdzc0TVprbXBSRjZxUFcvazZiSlM0UCtOTERl?=
 =?utf-8?B?WDZ2VGhha0J5aC8wbXl4WGU1SU1FWklIVkM4allwa00xcnMwOFBuZkFqU01a?=
 =?utf-8?B?UGdPdTMyTWtnYm5ITW9qejJ3M2hoNU9wenlaR3BBUDBjVW9nYkFFQ1hoQ2R3?=
 =?utf-8?B?WGlrc1QveHZDVkIxbEdZU05weGpHY2JjWjM0anByUW10MVlKSm5jZ2pzb0hp?=
 =?utf-8?B?dUZyb0dvRFJqQ3ZCd2xwTFMzRDhpalFWM0V6QXFYZzJGbVRFRk84S3VtZVFP?=
 =?utf-8?B?bHRQdG40TUNHeFVIRnlrbS9kSFRIekVIYng1ZFRoSW1mdjIvMHFmdjFsTmhF?=
 =?utf-8?B?aitXbFhrb0lNNEJXWm0wNHdYN1h1WVdHMWNvaFJnRDZVOUYyVVJrOXJOeGZB?=
 =?utf-8?B?VGdoVkhldU9DbTZJRnlXUGtUZHZxeUR4VnljUWVoWEd5WmdDeUdPQ3pJQnFW?=
 =?utf-8?B?WGM0RkVzSkpqUzVqSmdJOXc5cHdRTyt5V1VCR2s5N1I3ZFFYSkJTb0djUXVh?=
 =?utf-8?B?WnlLTGVnNG9WNnNMeE5HbzZHNWxzVGZ1RjhodHhwZUNQL0RZenBRSmhXcmRC?=
 =?utf-8?B?Sko0UTZKakl3ajgxYVdtVzhHZm9ZSFltV20xVTNJNUovdFE2c0ExbG1oWHgr?=
 =?utf-8?B?bWJad2JSeThIa3gwbWd3eFRXM29RZGE3VVdFd29EcktjVGlSRFozN0pNaXZx?=
 =?utf-8?B?Skg4dTRYYmlCT3N3UnBKWWQrTmRxL1hOVE45U0l0TmNGQlZLUlp3ZzhyRFZn?=
 =?utf-8?B?VWtUVTNuNFFCbDNrdUFqVllyWjZMOERUVjZ0cWk5QjZiOFVueER0YjhwbWJV?=
 =?utf-8?B?aHJocU82YWJUL241M2lOeUtDdVlYdVd2YUJVczZpdE9TQzhaMkMvcUYrd0Ev?=
 =?utf-8?B?aXRCRkVEU1VELzRZbFpWa0lxOEdwMnBzcTFoVmdWcXV6Y08xWE9UVGtscjRD?=
 =?utf-8?B?aVI4UzBDend2U0F3MG5lOGZIWSt0MHE4MnJBcFNKbEpUaUZnUEZvYXJkSldS?=
 =?utf-8?B?bDFOdXB4Q3VQQ3VCY09xbnFDeVJ6Uzl6czBwNDQxaVdOS1JlQmNBbDloaHRt?=
 =?utf-8?B?Y2REUEpSZ3VNWEdYclVPZ2lSNm03T0JWT3RPbnFVWTJGTVUzMGFSQXBRNmht?=
 =?utf-8?B?T2FBUm1UaThrQU9ZSE15OS9tenB1R2hwcGhvd2g5K1MzTmFBN0N6R0JQLy9G?=
 =?utf-8?B?S3B2ekQrTHdlUStDSUVuMEVHR1U1MUU1WmVob0l2MFNYNitxTi9vMVFOQ0Rk?=
 =?utf-8?B?WjRFMUJxWjRPNGhQUlZsZndRblYrNmhYQWVTNi9xbWw1K0NFSlNwbUo3U0Ry?=
 =?utf-8?B?WUVzeWlYWjloWm9Pb2s2TDRKYnphOEFFSUhWMzZacUdvOWZ2U2UzTHAzSFAr?=
 =?utf-8?B?RFBPR1VnZ3ZOcThjV3RqWG1PVzIwUTVuUFYrSXBzM0J3V1pzS1pjZHVVQStS?=
 =?utf-8?B?dDNaaUNrMmhvNGV0RlFlQk5Ya1R6bm8rSkdVM3UyMCt2Y2p2Smt2ZVlvVXBX?=
 =?utf-8?B?U2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 880c1b4a-95fd-4fa6-db3a-08dd6ec5177a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 13:24:53.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArfH4nTXc3wiQl0qNIhC3l91wu7l9+aTu5do3bN59DNn+dkicziuNPR8iHDkeVMbDX7mfJ15cxv43bNKrbB2D3j7Wp3cq38uC9NqRcySFEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15714

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDE1OjI3DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTYvMThdIGNhbjogcmNhcl9j
YW5mZDogQWRkIG9ubHlfaW50ZXJuYWxfY2xrcyB2YXJpYWJsZSB0byBzdHJ1Y3QNCj4gcmNhcl9j
YW5mZF9od19pbmZvDQo+IA0KPiBPbiAyNi8wMy8yMDI1IGF0IDIxOjE5LCBCaWp1IERhcyB3cm90
ZToNCj4gPiBBbGwgZXhpc3RpbmcgU29DcyBzdXBwb3J0IGFuIGV4dGVybmFsIGNsb2NrLCBidXQg
UlovRzNFIGhhcyBvbmx5DQo+ID4gaW50ZXJuYWwgY2xvY2tzLiBBZGQgb25seV9pbnRlcm5hbF9j
bGtzIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gPiB0byBoYW5kbGUgdGhpcyBkaWZm
ZXJlbmNlLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQr
cmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gQSBmZXcgbml0cyBidXQ6DQo+IA0KPiBSZXZpZXdl
ZC1ieTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gDQo+
ID4gLS0tDQo+ID4gdjYtPnY3Og0KPiA+ICAqIE5vIGNoYW5nZS4NCj4gPiB2NS0+djY6DQo+ID4g
ICogTm8gY2hhbmdlLg0KPiA+IHY0LT52NToNCj4gPiAgKiBDb2xsZWN0ZWQgdGFnLg0KPiA+ICAq
IEltcHJvdmVkIGNvbW1pdCBkZXNjcmlwdGlvbiBieSAiQWxsIFNvQ3Mgc3VwcG9ydHMgZXh0ZW5h
bCBjbG9jayItPg0KPiA+ICAgICJBbGwgZXhpc3RpbmcgU29DcyBzdXBwb3J0IGFuIGV4dGVybmFs
IGNsb2NrIi4NCj4gPiB2My0+djQ6DQo+ID4gICogTm8gY2hhbmdlLg0KPiA+IHYyLT52MzoNCj4g
PiAgKiBObyBjaGFuZ2UNCj4gPiB2MS0+djI6DQo+ID4gICogTm8gY2hhbmdlLg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCAzICsrLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gYi9kcml2ZXJz
L25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBpbmRleCAyMGU1OTE0MjFjYzYuLjdhZDI3
MDg3YTE3NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZk
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBAQCAt
NTQ2LDYgKzU0Niw3IEBAIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gew0KPiA+ICAJdW5zaWdu
ZWQgbXVsdGlfY2hhbm5lbF9pcnFzOjE7CS8qIEhhcyBtdWx0aXBsZSBjaGFubmVsIGlycXMgKi8N
Cj4gPiAgCXVuc2lnbmVkIGNoX2ludGVyZmFjZV9tb2RlOjE7CS8qIEhhcyBjaGFubmVsIGludGVy
ZmFjZSBtb2RlICovDQo+ID4gIAl1bnNpZ25lZCBzaGFyZWRfY2FuX3JlZ3M6MTsJLyogSGFzIHNo
YXJlZCBjbGFzc2ljYWwgY2FuIHJlZ2lzdGVycyAqLw0KPiA+ICsJdW5zaWduZWQgb25seV9pbnRl
cm5hbF9jbGtzOjE7CS8qIEhhcyBvbmx5IGludGVybmFsIGNsb2NrcyAqLw0KPiA+ICB9Ow0KPiAN
Cj4gQnkgZGVmYXVsdCB0aGUgZmllbGRzIHdpbGwgYmUgc2V0IHRvIGZhbHNlIGlmIG9taXR0ZWQu
IEkgdGhpbmsgaXQgaXMgYSBiaXQgbW9yZSByZWFkYWJsZSBpZiB5b3Ugc3RpbGwNCj4gc2V0IHRo
ZW0gZXhwbGljaXRseSB0byB6ZXJvLg0KDQpPSy4gV2lsbCB1cGRhdGUgZm9yIHNpbWlsYXIgcGF0
Y2hlcy4NCg0KPiANCj4gPiAgLyogQ2hhbm5lbCBwcml2IGRhdGEgKi8NCj4gPiBAQCAtMjA0NSw3
ICsyMDQ2LDcgQEAgc3RhdGljIGludCByY2FyX2NhbmZkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAkJZmNhbl9mcmVxID0gY2xrX2dldF9yYXRlKGdwcml2LT5jYW5f
Y2xrKSAvIGluZm8tPnBvc3RkaXY7DQo+ID4gIAl9IGVsc2Ugew0KPiA+ICAJCWZjYW5fZnJlcSA9
IGNsa19nZXRfcmF0ZShncHJpdi0+Y2FuX2Nsayk7DQo+ID4gLQkJZ3ByaXYtPmV4dGNsayA9IHRy
dWU7DQo+ID4gKwkJZ3ByaXYtPmV4dGNsayA9ICFncHJpdi0+aW5mby0+b25seV9pbnRlcm5hbF9j
bGtzOw0KPiANCj4gTml0cGljazogaWYgYXQgdGhlIGVuZCwgd2hhdCBtYXR0ZXJzIGluIHRoZSBl
eHRjbGsgYm9vbGVhbiwgeW91IG1heSBkaXJlY3RseSBuYW1lIHlvdXIgZmllbGQ6DQo+IA0KPiAg
IHJjYXJfY2FuZmRfaHdfaW5mby0+aGFzX2V4dGVybmFsX2Nsa3MNCg0KT0suIHdpbGwgY2hhbmdl
IHRoZSB2YXJpYWJsZSBhcyBleHRlcm5hbF9jbGsgZm9yIGNvbnNpc3RlbmN5IHdpdGggY29tbWVu
dCAnSGFzIGV4dGVybmFsIGNsb2NrJw0KDQpDaGVlcnMsDQpCaWp1DQo=

