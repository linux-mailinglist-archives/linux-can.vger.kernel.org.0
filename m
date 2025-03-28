Return-Path: <linux-can+bounces-3274-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC7A74A11
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E4F3BBCE0
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD81DFFD;
	Fri, 28 Mar 2025 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="io395a7d"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616B7462;
	Fri, 28 Mar 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743166078; cv=fail; b=hwl/y9nVwStPRFLQ7g86b77VI8oCrWQ2+I5Nq0jjFlQd9tH7QiT4hR0w5YJIKz5FDJmy6VlX20mHTZt5KcyFalpJOPAUYNGhaKf2EyDziiymhHkhBoaZN8YfsJnvs4dyeJxjywVm3f38iMglyisuJdAyzVsvZ8ENdreVqcI/wMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743166078; c=relaxed/simple;
	bh=vbDdvVwYoDw+hFzPCLGdPTNcVzEplKtCnbTbfDZiYF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tspbtbli4HUq17eMb3aND51iwwwrLVYytQ4Dk81x+Ns29ze1zOqyQujeG+om8/LnW5UHs9PHib5q1WLul+RF7Fw0IwIPDD+CaT+Jjtet35v/f7rwgdcLBMByNpERyQ6fn55S8ERg0/QEcTJvIO0srAPCJSaVJnuhj1dDTpcbDVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=io395a7d; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQDNtbBnnCMwCsNAq3tvny1rmoveAKb1G/ZLry90jry8E3cno+OYvjgHyOR//qJmwd63UGt0KRkYDvksG5MVXf2yKvWURmX9l99rlLyYQrHlI0xaYSggsPNQeqO+gA8E8xFH7ZtCZ/XjoYOkcuo7eAFPhZjzL2q/mt+zAWUzq4O6wFg4nHkx/LogMXMPSyh8bpvdh3m7qIKgl+4YUxSGf9OfgoSBiAjvUov7TeBnezqgdm8lSRG4XzLFZ/Q81NdV5/BzTVlx0kl/ySRdeUchWwNDY8Eswry6bAz4maDjYLKhwZ1RDeu0jb+QP10HMCyD35qGOVtEIqWBVdQPZ+E/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbDdvVwYoDw+hFzPCLGdPTNcVzEplKtCnbTbfDZiYF8=;
 b=mcGuQCzffRVIUAjN7jt8Vr8jHmmNCRSdk5yfMWl0ZLxPdUAw2TeTtQjozFQm5ZcoXCnWx/XQxPzVu4/tjNzYtIPNij61bYK53bwqU6Mxjvx1b/GuZ3CwKAIF4JXVvUr4TpmLJXPiPCvllQdqPCeilTxdvAauX4FsVUkcTp/jdkIKeiLNie2CmdO025ibBBJFwGJv1mjXK88mLKuxa1Xdm+fCQFUujdg3gaKLVCRiHu1nLbQ46BbHZTcm0gshAFGDa1NcWT+yBX73i2ly1g2mTAVxLTG/dHGPE9rJB/Wr9158tvlg2RLv3Xi074R2OmaHHhAGEWBpEwfA6n3ugVvMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbDdvVwYoDw+hFzPCLGdPTNcVzEplKtCnbTbfDZiYF8=;
 b=io395a7dhoQiGl39z6gFATmFZfucdDsUWuX96/fxQHRPzhCs+dtjSPnCXE00gtPoas9Tk4gdiMDS8cFBJVRYzH0JCgSOhzjywuB16a9gl+TAf8QIaDxT16ssbjuUbBNIQ+08bOiGLhQOX6DfS6KXxzbQCDmyqWnNvJRsAfSm6fk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15807.jpnprd01.prod.outlook.com (2603:1096:405:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 12:47:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 12:47:51 +0000
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
Subject: RE: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkmCjkAVW17T00yjXS76ILH9B7OIZhsAgAACf1CAABg2gIAAAUOQ
Date: Fri, 28 Mar 2025 12:47:51 +0000
Message-ID:
 <TY3PR01MB1134639808EACAF305EEC2E9286A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
 <98b10d18-89ae-4fef-b9e3-f548b88c616f@wanadoo.fr>
 <TY3PR01MB113466234D837B22985BBCE0D86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ba276015-b649-4e5e-a69f-93830812c59a@wanadoo.fr>
In-Reply-To: <ba276015-b649-4e5e-a69f-93830812c59a@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15807:EE_
x-ms-office365-filtering-correlation-id: fceeb1bb-23ca-4100-7a13-08dd6df6c08b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEhyYjBYUXoxellBemhhc1FpSWNIL2dSdmVZSmc4M1IyaS9HcFZROGxBMVdl?=
 =?utf-8?B?aFphM0lpYXFLUE9WSE9iMEs0QWs3VENRMmsvUHMyeTUzY2NHalJkcnQ5UWpZ?=
 =?utf-8?B?MWtKeE5lRTJtQUxuRzg0TUtBMW13Y2xGNmVQT1BOM1p5dG9XNllUcHpPOUdW?=
 =?utf-8?B?YmRWRDZ4NnBqM2lhdlNjcTA5ZktpUDNkN0JhR2VDSUR3UlVQTGxvenVjcUs1?=
 =?utf-8?B?ZVBjY1cxdFVySzN0cFpmeFRPc29naTd0dm13eC9JU3RFQnNDbGtoNFJuSXFk?=
 =?utf-8?B?cnZnUTdYYm5RS2dtcEhvbk54Mjltb3NkVXZoL3JFbDNEeFV1R1pvTW5JdTlO?=
 =?utf-8?B?SEwyQ1Q3N0ZvWi91anpJVDUzVFdyc1o0VlJQLzl4ZHh3NVF0aCsyRVhmUWtQ?=
 =?utf-8?B?eGdZMjBMWTRXV1h5c3BUSGxJTlFVMkh2RjlYWHhrNzd5Qk5GSXVkWEx3ZUhS?=
 =?utf-8?B?bkRLbWVOazNXazBVOTNhZkZ4ZzIzTU9jZXJXajArZU9qSUlNUEU5NzVlcmhI?=
 =?utf-8?B?Z2Q1b1JZandZT3hXUFlkTE8rRC8wS1R5cDlFT2VqMFZ0ZUFzaEhNWmNSL2Zo?=
 =?utf-8?B?RFo1VUd2TGlSVmJkU1V6dTQvZW9zaDVLR1oxcFZHRWNQTlluQ3ZBMCtUVkQ2?=
 =?utf-8?B?OGlUWmdoSGJodzB5TW9LQ1VVcEJrY3EvSEtKd3hIaEsxZjNtNGlBVlNITk9Y?=
 =?utf-8?B?ZWZrb0oyS0JkNUFKNU5XN1NVQUNnM1YwdjlKNlVzQ3YwRnA2VGNNdGdOWDZs?=
 =?utf-8?B?cUs2WjdJMHJzSUlMa3EzMHVUNE5WemxUV2dwT2tUM3U5L2NKOWlUc2FDNUxZ?=
 =?utf-8?B?ck14SDViSGl2ZktxTEU1Y0lDK29SeUFsbWk1cWcxTElhSVhKRVd0WHdXdE1L?=
 =?utf-8?B?Y053UHNra3Z1bnBWOHhiOG9zQWZPc1pTN0FmcVg0TS9FWEtlQkE1QVRycDY4?=
 =?utf-8?B?WWRmWjRxMHJLakF1ME8wbUsxUGREekVRRGpzMklRTDdhY0NlNVl2MjM5bzFW?=
 =?utf-8?B?TlRlckhlTk5ONmk1dlJZdUJTMHh3TEo2TU0vYmJPQjZxcXo0QmJlYW5sQlBm?=
 =?utf-8?B?UDJZdUZzU1N2amkwQUdSYXJuaFR5NVRZZCtyY1FNclR2R1ZHQzc4ZVBHcTli?=
 =?utf-8?B?RHZkM3Jybi9jRjI2R2lXcFc0TTByYWhxK1QrTDV0R3BtWHRBSjdpaGhzSzZ0?=
 =?utf-8?B?MDVSRTVNdTVGb2FIOHc0cWcrU055eDdlV0owRWMvUk5LSlRkVXd6em5SVmE4?=
 =?utf-8?B?T3FhdDBackVRNmtNTHdwa2NXeWFKaU9Vc2lhVXBTbllTTnoxbWxKTHdybkVh?=
 =?utf-8?B?Z010eThGbGxyQVZ0ODI3eHJ0V0lTUDY3RG5QNURtSFJhWHplNnBIV094c2Fq?=
 =?utf-8?B?YnlyNzg2L2RVZWVmNG9kOXpPbFV4Y2FDcGcrZFR3ZGI4YkpGSU11YnNuQUNO?=
 =?utf-8?B?b25kL2o1a3dwcmRUN2dzbHo1TnR2UEs5U1M3aTVlU1dxNTZOMmFPWUF2cjVm?=
 =?utf-8?B?VW1aMlFlcE5TbVA4eVU2cS9HazNZZ01zRGdpMUVKa2xLZXkzR01KMzZIcG8z?=
 =?utf-8?B?QTNlZG1obDlaWVdBS3RXc2VSSW1lMnliTU1STjFncHhUY1hqRnFnU1NsN09p?=
 =?utf-8?B?V3haeDhYY2lqdzRPNG9GcVlQS1hQNitiMjhCdWxMa2RNbmtVaE95YkpneEZr?=
 =?utf-8?B?YTAvZVVYRkNVdmpMYUlWaHl5Mm1MaTZaTjJtSUJ2YVRQTytnbEpOVUM0L1M4?=
 =?utf-8?B?YlBTNi9ZWVpDb002b2RHL2RWQXZQMk9vNnA5TzJjemZHYTVTRGRLZENOeUx6?=
 =?utf-8?B?VTBkSzQ0ZkFKVFRadVVZYkoxQ3VHRkl4S1FVT0hpaXFtUkNZdU1TU2RvTlVa?=
 =?utf-8?B?NXlTdnpwdVlqSzA1aWEwMVpzU1FLaHdIcXYyZ2l2bWtGR1VUaEIwWllXWHNH?=
 =?utf-8?Q?yl2a9wKLahnzzx/InmKsTvXvUFsKWaXl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?endEV3l1elJLREV0ZmlqdzFVTUQwb0w1ZkgxWUxVV3FIbmg3TGpWWk1UVkF6?=
 =?utf-8?B?endsdzRHTXA2TEVOVU5qNFIxOFZFVG1zVjkwVFdFWWFOV083Y2l0YU5PNi9o?=
 =?utf-8?B?OUhzaTFObjcycC9WamF1UXJVMmtzTUI2Q1FBSWI3VFgwVGNsMHA2QTZFTU4r?=
 =?utf-8?B?TWpFMXJJR0Y3T2RXUkdOUWJEckczdzh2RFY0K01iQmNERHhOZ2s4VXBoN0FP?=
 =?utf-8?B?N2lvdE9kQW1aWVBpS2tta3VUNWdzTmJ6L054MEJ5U1Fwa0k4dnhhQ3VCV3U5?=
 =?utf-8?B?eExKaFJvSHMxdmpDRDltdHMwUnN0dUs2NDEwQlh5ekNwbDJBUXNXYmVRSFll?=
 =?utf-8?B?Ylg5UmtJQkxPejlIZFpRYlZ1Z3A2NEMxYitYaG04eE9wZWE4Q24rSVdJWEZz?=
 =?utf-8?B?V3BuUDhRY1RuOUZ2VzlJWUZxS3A1ZlIxWjNsTllwMTRTMHpMNUJZUmIyYy82?=
 =?utf-8?B?disrdFl3eHpmZFNQbGFaS3RzQUhCYlpyejFXTmVoTFQxS0M3MmZ4M29YRUJR?=
 =?utf-8?B?ektZZWcvOUNvck5GRWdWWEh3bTVBaVZDS1pBalo0OWlVRE40emNxS2FFOGlu?=
 =?utf-8?B?a0loSGRlajI2UXJXdjQ5Q2ROL0Q4dVpNdloxN1oySHY2aDFHN0kyM0pTS3Jw?=
 =?utf-8?B?aG0vSlp5bDJRa3hXU0RhT0xlaHNRMVFpZkw5a1hGSk93L1p4NzZDa0xZS0Zk?=
 =?utf-8?B?blE1WjdTNVRFYnIydXB4MERHNTFtZVBDbTVrU0g3UE55NlBRZHVLZmVqN0ZF?=
 =?utf-8?B?R1hnVGg5aFcwNFlnU2k4NkREb2dnV20vN1paV0hydTNzODVsUFJ2NzJKVEdS?=
 =?utf-8?B?ZUV1Qk5UOXNzMFNJNDQrdm9VUFY0RXJlNkJqYnNMV1ZCNWp5RDBqOGNXNUFl?=
 =?utf-8?B?Q3dsNTQxa1RZYzR6V25KVHY3OS9Wbm9lbmRkNEVvWFEvMjVyb25lUVd2UHNU?=
 =?utf-8?B?NGZhQ1FIRDlWbWY0U3JmWHNFQ0M0cjQwVUwrOWVjOHN2dlgxZ3lFSzRHenI3?=
 =?utf-8?B?OHFNa1FacXYzODVvMWhXVDgwejZTaHp3eFdXckMzKzczcDlWODVzRTRyTC9C?=
 =?utf-8?B?N3BZWDZhSVhId1Job1ZKSHR6cVZMSFRlQzhnaW1mUzc4TlJDQjdtOGtiOUVR?=
 =?utf-8?B?T3E5M1Y5ekhqdVZiV1pzNTRoVDQ3UzMyT2FqRC9qd2hRT3FjRHFCdXE4dUlX?=
 =?utf-8?B?aURZUVIrellzMGh2VFlyMUpKMUpydDZ6Q0NjRUFpZFk4UzNLNktQOHJjRGNR?=
 =?utf-8?B?Q1FnQTgwajV1NmJBbmR2QzB0UEF5UW5waWNlNGZ0aXBzOTV3am92Q2ozNHNX?=
 =?utf-8?B?cUlYTUxnU0xNZ3pMSDZaTXYyYWh5eG9JbmVkZDJtQlVWYU52dXJTMERRcGdJ?=
 =?utf-8?B?dk02WXhrbEFBWGVqL0ZGVXI5YVpGQjFPWmFYakNnbDkxZDZhT1JxdElZeDNB?=
 =?utf-8?B?L05sWUpYOFdGZ1V2Y2Z5Z2NzWG1KTkFZVDJWR3pZMWNhSGpYTVJDLzhPWHhi?=
 =?utf-8?B?Z3QzSlowUm94Wk5wQjNFYld4NDVOUXVvQ1MxMlVibFJ6MlNPL01KVzh5QUt2?=
 =?utf-8?B?ekF0VFNBd1JMU2o3VCtYUG5aWjUyb21McjZ3S0o0QWtRUDNGSDdjSVlVZjVI?=
 =?utf-8?B?TDBLT3l4MkZXM29iNEtSQ0U2emg5VHlwL2dZTFZDWFpuTDEyTWhyR2VSK1FG?=
 =?utf-8?B?S1prZjY0SE1NTTRyMTlLQjZJay9JTWpra1AxL1pYb2hHSU1zTGd2eW9rU0ts?=
 =?utf-8?B?UUQrbjJVcjloRS9FZFVpUjcrWHZ2M0dyZXh6OVZEWEJDWDRFREszZlU1MjZs?=
 =?utf-8?B?bk1JYUtPQ0EwU1l4WVlkRGk1Q1BOeFRiWWEwY3RXSGQ2amVBN2ZhUjZCbTM3?=
 =?utf-8?B?ZURHNWtUd2FWYU1LNGV0a1hRK29MNmxrY2xjeGludjNJK0xTNWFFdHhEYnk3?=
 =?utf-8?B?WVRlSHM4bFNiNmxxSmkxNlUzdlR0Y1ZIM25jUU5TOHhYUHQ5bi9jS3FKVk43?=
 =?utf-8?B?V2N6Y2tXOG96UUNUclhwOTdmZm9IZzA2RldmbzRXYlJLRmxEaExXYnRZZFhz?=
 =?utf-8?B?QXVWZlBhZDc2MlE3aEliV1ZWUUsxWnM3UFEzSVMxL3BhcG1GRnErcVpsYjhU?=
 =?utf-8?B?eExsWGFpdk9MdUpScFhRS2JWWjhLVlFwNVJWREtqL25FeEFzN0lXWWtkWEZX?=
 =?utf-8?B?Wmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fceeb1bb-23ca-4100-7a13-08dd6df6c08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 12:47:51.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sl0L1in+GVR5axcZpNrqlga3a1mUBeaSSjwwPKhJF2YZg1WsKJRH+40bnrARVI/YtsniWApo6RMK+kewVRy+BE9qzoOTXPLpT4PrLJ4G3lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15807

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDEyOjQxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDkvMThdIGNhbjogcmNhcl9j
YW5mZDogQWRkIG1heF9hZmxwbiB2YXJpYWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZv
DQo+IA0KPiBPbiAyOC8wMy8yMDI1IGF0IDIwOjE3LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBW
aW5jZW50LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+ID4+IFNlbnQ6
IDI4IE1hcmNoIDIwMjUgMTE6MDYNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwOS8xOF0g
Y2FuOiByY2FyX2NhbmZkOiBBZGQgbWF4X2FmbHBuIHZhcmlhYmxlDQo+ID4+IHRvIHN0cnVjdCBy
Y2FyX2NhbmZkX2h3X2luZm8NCj4gPj4NCj4gPj4gT24gMjYvMDMvMjAyNSBhdCAyMToxOSwgQmlq
dSBEYXMgd3JvdGU6DQo+ID4+PiBSLUNhciBHZW4zIGhhcyBtYXhpbXVtIGFjY2VwdGFuY2UgZmls
dGVyIGxpc3QgcGFnZSBudW1iZXIgb2YgMzENCj4gPj4+IHdoZXJlYXMgb24gUi1DYXIgR2VuNCBp
dCBpcyAxMjcuIEFkZCBtYXhfYWZscG4gdmFyaWFibGUgdG8gc3RydWN0DQo+ID4+PiByY2FyX2Nh
bmZkX2h3X2luZm8gaW4gb3JkZXIgdG8gc3VwcG9ydCBSWi9HM0UgdGhhdCBoYXMgbWF4IEFGTFBO
IG9mIDYzLg0KPiA+Pj4NCj4gPj4+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBXaXRoIGJlbG93IG5pdHBpY2sg
YWRkcmVzc2VkLCB5b3UgY2FuIGFkZCBteToNCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IFZpbmNl
bnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+ID4+DQo+ID4+PiAtLS0N
Cj4gPj4+IHY2LT52NzoNCj4gPj4+ICAqIENvbGxlY3RlZCB0YWcuDQo+ID4+PiB2NjoNCj4gPj4+
ICAqIE5ldyBwYXRjaC4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3Jj
YXJfY2FuZmQuYyB8IDYgKysrKystDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPj4+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+ID4+PiBpbmRleCA2MmNkZTFlZmEwYzAuLjdjZWYwNjczZmJjOCAxMDA2NDQN
Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+PiBAQCAtOTMsNyArOTMs
NyBAQA0KPiA+Pj4NCj4gPj4+ICAvKiBSU0NGRG5DRkRHQUZMRUNUUiAvIFJTQ0ZEbkdBRkxFQ1RS
ICovDQo+ID4+PiAgI2RlZmluZSBSQ0FORkRfR0FGTEVDVFJfQUZMREFFCQlCSVQoOCkNCj4gPj4+
IC0jZGVmaW5lIFJDQU5GRF9HQUZMRUNUUl9BRkxQTihncHJpdiwgeCkJKCh4KSAmIHJlZ19nZW40
KGdwcml2LCAweDdmLCAweDFmKSkNCj4gPj4+ICsjZGVmaW5lIFJDQU5GRF9HQUZMRUNUUl9BRkxQ
TihncHJpdiwgeCkJKCh4KSAmIChncHJpdiktPmluZm8tPm1heF9hZmxwbikNCj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4gV2hpbGUgYXQgaXQsIGNhbiB5b3Ug
cmVuYW1lDQo+ID4+IHRoYXQgeCB0byBwYWdlX251bSBpbiB0aGUgbmV4dCB2ZXJzaW9uPyBJIGRv
bid0IG1pbmQgaWYgeW91IGRvIGl0IGluIHRoZSBzYW1lIHBhdGNoLg0KPiA+Pg0KPiA+PiBJIHVu
ZGVyc3RhbmQgaXQgd2FzIGhlcmUgYmVmb3JlLCBidXQgdGhhdCdzIHdpbGwgYmUgYSBuaWNlIHF1
YWxpdHkgb2YgbGlmZSBpbXByb3ZlbWVudC4NCj4gPj4NCj4gPj4gUGxlYXNlIGRvIHRoZSBzYW1l
IGZvciB0aGUgb3RoZXIgbWFjcm8gd2hpY2ggeW91IGFyZSBtb2RpZnlpbmcgIGluDQo+ID4+IHRo
aXMgc2VyaWVzIChJwqBhbSBub3QgYXNraW5nIHlvdSB0byByZXdyaXRlIHRoZSBmdWxsIGRyaXZl
ciwgc28gb25seSBkbyBsb2NhbCBpbXByb3ZlbWVudCBvbiB0aGUNCj4gcGFydHMgeW91IGFyZSB0
b3VjaGluZykuDQo+ID4NCj4gPiBJcyBpdCBvaywgaWYgSSBzZW5kIGEgc2VwYXJhdGUgcGF0Y2gg
Zm9yIHRoYXQgY29udmVyc2lvbiBmb3IgYWxsDQo+ID4gbWFjcm9zIHdoaWNoIHdpbGwgYXZvaWQg
aW5jb25zaXN0ZW5jeSBpbiB0aGUgZHJpdmVyIGFzIHNvbWUgbWFjcm9zDQo+ID4gd2lsbCBoYXZl
IHggYW5kIHNvbWUgbWFjcm9zIHdpdGggbWVhbmluZyBmdWxsIG5hbWU/DQo+IA0KPiBUaGlzIGFs
c28gd29ya3MhIEFsc28gT0sgaWYgeW91IHByZWZlciB0byBzZW5kIHRoaXMgaW4gYSBzZXBhcmF0
ZSBzZXJpZXMgdG9nZXRoZXIgd2l0aCB0aGUgcmVtb3ZhbCBvZg0KPiB0aGUgdW51c2VkIG1hY3Jv
cy4NCg0KVGhhbmtzLg0KDQpCaWp1DQo=

