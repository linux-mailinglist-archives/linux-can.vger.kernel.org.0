Return-Path: <linux-can+bounces-4511-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A81B48A58
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829463AE0C0
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F92F39CD;
	Mon,  8 Sep 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="osQt+n4S"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010068.outbound.protection.outlook.com [52.101.229.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862C2139C9;
	Mon,  8 Sep 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327904; cv=fail; b=QlrZU2WqpLzcOed5NoF63zlcJDDOTlVpz6xOKHDd91AhHKHwwRnHXXQ+TRuIeE+hW/wJF1JpNNOS1Pym6qLOQ6pTzxPzmCDnWHIyXWUd+RUv07yprFw5RCFnjQ2ruaeZa+vYzwT0Yc8qpAbxujskPCgPezfDafT5MBC6MI3k+i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327904; c=relaxed/simple;
	bh=KrwMXVATFGd9OBTz9ConxodTjrJKQBXwFBHTcJ1Ebtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqVZ/dl2kMUNO1ia8fpiZCTJQtDfcpz9g42tlbQ5ZWlq4/fiTsYcJG9aEkBP8e+c8jk7xXtV4OS59BZKemMwdHun9AsENy9RkLEiSgToSX9PmcOdaPxzdFb06J83R59LoPYX+vp3vJpdKLsRn8ajLoY3PRvZT3upTv0CUvlVAow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=osQt+n4S; arc=fail smtp.client-ip=52.101.229.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYx6b+9F71Hba1B32M4Nk9oMK+gltd0dxSaDB2VzLYEJAx5bDxWC+eQh/n6QHPtk7a8lNLXmh1zifCsm4w601b11lkNXvxpxJP537xvJ32JTit1Fs0O0rQEea4M/VVqD3PfmTEfuCSYORezo/EnzXz45YD0Dfy85/AAm2eUCZ70AT0gHFagH1nNGUaKTVHlEBX2WOqehCW4NtFysU2tvYgyugD1K2myHFKNX+IfegtdblEjNVovESUc6iD02yvDpwu3ciM0TS1GZWSBJ2hbooL9EjUDot9dfJB29utmLysDt8/eM7FjP+hnJ2aJ6DoM7Zz8ldk1keJ1t+67fmH4kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrwMXVATFGd9OBTz9ConxodTjrJKQBXwFBHTcJ1Ebtk=;
 b=a+OuCqgukVIhCnfKGJA4bf3+8/I0G7w9+FGgdB6JI1OuuOP5e4ezWOqbZdCyro3CVBi+ozb2emIA967p2DWAeUUwqqY3FpK3p4rQv8q5KrhDdCJDZyM46ubDHT5tI8+JH89LERIu14arwppIMJmgissKsNhKGw5ziLT3jnBbdeiLPdj5oOnDHdE2CJwYrmrHQ6lTS1ZLBdoE1FkYLO+9iwBIbn94W7Gf7ev0pjMne4uOLGX4rr0sOszV558Q4MY6qksa2CuYyUzaYcPRVMsivnHe1LKMguEMvZw0RmBOyFxApWCpAWHA+jXW8z+KyMBm/+YMz5wo64fys8ihpRfc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrwMXVATFGd9OBTz9ConxodTjrJKQBXwFBHTcJ1Ebtk=;
 b=osQt+n4St7Kh20A4jMXyhFLLKlCI29r+empSdAycir2tVUApIbBxXa6orqEU2gPPT0wv+TvYLRmnVVwHEZbk5/nXXAuNAYcQX1ksijMsDXJ1tVZbv5b2t5FopNGv8gvEh6GPhzZc7XFOG/5ZwMc4HTd4qv+D5tN1VM93CQz9qI4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7460.jpnprd01.prod.outlook.com (2603:1096:400:f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 8 Sep
 2025 10:38:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:38:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
Thread-Topic: [PATCH v2 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
Thread-Index: AQHcEqXuui+8tPdpbEGdmojhP4YIi7R+YikAgArRo9A=
Date: Mon, 8 Sep 2025 10:38:19 +0000
Message-ID:
 <TY3PR01MB11346C45891228113FBF409B0860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
 <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdU8pyRPiS-q5N-WKXLTX+hiNQSR8oPVkoV-VoKHgOp13g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU8pyRPiS-q5N-WKXLTX+hiNQSR8oPVkoV-VoKHgOp13g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7460:EE_
x-ms-office365-filtering-correlation-id: 62af0072-e483-4998-d5db-08ddeec3d396
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnFhbGRRa0wxU283RDdNZXlJN25hTmduQ2VyN1NwaU0wSCtwbTU0WUJnZCti?=
 =?utf-8?B?MkxCK05iaXhGci90R1ZkbUtNZ1Z4azB2ZlZQYWRnNERHQ1Z1UEZJSmZ1Z3dh?=
 =?utf-8?B?MkltWHZuTFU0YWE5WUxPcERZVUJmQ3JwY1dUMEdLS1p4MW01aDV0UXlCQnA3?=
 =?utf-8?B?VGJwaXhWeVRmbTFFUFVuNkZVWXk5THZBUGlCZlQwdEViWHhob2thUU9ZTGJo?=
 =?utf-8?B?UG4yK2NhMU85QXljNHZhNG9tWjZZcVpyOHVVdVdhdlArdG9saW9UOFpnUkd1?=
 =?utf-8?B?bmhtc3pZTk5mbEFJOVZWYjI1NXVkS1RONVc1ejRDSGpGV1JHa1M5WlZLcUVP?=
 =?utf-8?B?Q2ZoM1lubjZIUGVKd2RmVHY1WTFCRVdwSHFtM01mZ3MyZU51SVkvMURSSk4r?=
 =?utf-8?B?Ym9uT1hvUFJMcEYyL3c3dVJZYVNSb1Rna21HbGNKZCtYMkxtWHZhdTVVV0tC?=
 =?utf-8?B?ZkZ2ZzNhc0NiTnRCMUtqWGJtTUhTenlVWE5iRUEvWW1uT0pUMlNqSnBRaDBT?=
 =?utf-8?B?SmhMSXdabG56WlJkTm1SU3JvODZ1TWFUZHhSSWE3YTRnYnZ0TWpFbE5nd3cr?=
 =?utf-8?B?RlBHWTdVMW1nTWxwVERGaHpzV0hFdG8vemdqMEpkUUJ1N090ZG05REYraDEx?=
 =?utf-8?B?S2JtaS9mcnBMVHJ3dWg3alBEdDFTT283S2xBUk9uNUprU0VwU0VSeFdtYmIx?=
 =?utf-8?B?ZnoxWlN6VTQ3N29Oa1FzRUpQOEk1ZHUrU2cxdEt0N1A0VkR4c2dlS3pVVE01?=
 =?utf-8?B?TWthWkYzYnQwOHo5TkpwK2lTK0RjMzJpS3JsS0tvOHZqRkN2RWdsK2hUaU53?=
 =?utf-8?B?YlJQMTBwTEtXdTVxVjRLMVh5TmorbWpLdlUreXA0eXk3QmNabWIxQzlvcEZ5?=
 =?utf-8?B?Sy9RS3RPSjBscmY2SDdUdlk4R0VLajFXN2ZwZUJKMS9za0JocFptaENXSVRC?=
 =?utf-8?B?V0NRZVM0S3A1ZklUY1M4Qm9teTFTaENTWE9VQWtORDlwS05VSHd5M01UazBk?=
 =?utf-8?B?SFBrbzJTU3h5S0ZJa2pkTy9EWVVFWjVKY3Ryb2ZxaVFYSjRHRG8rMFdLSmNr?=
 =?utf-8?B?TDZUZGU1ZFhWT0s5Mkt1L3ZOOWJRVXdDd0N1ZUFac3lzaDdyWUFjZXdpVkw4?=
 =?utf-8?B?djl0OVRoZmNRL0VCNjVCQTlkenNEMFkrMTV5RTZtVEFpOHVsR2l4cVBIOElV?=
 =?utf-8?B?TkhHc09UMGRJZWhnR1U0TThtQkFvdWVPQ0Y3Q2M1OG14Uk0zZFJlUEdwN1ZI?=
 =?utf-8?B?dExwTkRCbGVUK2Z3Q0FRb21nTmtGc1Z2U3RqMGxYTzQwTVV1U01ZSDc4MUhC?=
 =?utf-8?B?NlRBWXd0TUYvYVBzcFF2dGpUUW9VNDAvYURERUllQzJMWWxtUlh4SGZVYjNm?=
 =?utf-8?B?Q3R4RFNmRTNuQ2ZJbnNUNldUdUVDVjhSdlNRNGkzdHlmNmowd0paRGs5amV4?=
 =?utf-8?B?Q3cvd2tjZU45VlJoY1V3TVVPMGJod3JZbENCdlhNdDNOVjcvamFNSGZxdlFY?=
 =?utf-8?B?VEtpaXZRWmVjenRHZnErd0RoZmdVK2hUdkcwNVp1N3VHUjZYQ2pHa0xOdHFR?=
 =?utf-8?B?aXR6anpVb2R3aEVHWHdkVVQwbE1oYWNEUUNzYW15UEJocTVNeHdFVFdxbVJ6?=
 =?utf-8?B?WTNjN21ac3FOZDZ6UTBKTHJJVGU5WlJpOU5NU1QwUjhqVVhFbHY5d1BjakpQ?=
 =?utf-8?B?UGVBVS9NdkFoZzVWWmtJbWg1VVI3SWhQbEMzOHV5clJXZklNMitqSXpGVEdn?=
 =?utf-8?B?Wm5ycHA1dTR1ako5VkpjenpEU21QWVRoVWlMOTFRMEY3c2ZWSWdEVHpwWlhU?=
 =?utf-8?B?Q0dLb1BoTHp5RTBTT1ZrMGM2SEJoU1hGaEhiMGs3czdOREZlT0hXY1V3bFJo?=
 =?utf-8?B?cnkrOS9udE5ReW9sSWRVOVpWdk9sNmRtdXVFcXVoUlFla3lUWGlDT1BpT0d2?=
 =?utf-8?B?c2d0UmtCRHJUMHZhV2NtNXNYUjhXbDJGTUJTYVlXSWZKRy95aFhpaW5CVVRG?=
 =?utf-8?B?QmU1WUlYdEVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEJSVGRVSG5vamJvQlcwSjN3TUlmc1dnMkxma1ZnbFIxYWFMQVdGN0hOcTEz?=
 =?utf-8?B?T20vV252ZlN0Y2JtazhDbjdFUUNSeVY5d1dBS3JCTTRqUFRtdFlmb1pycVR6?=
 =?utf-8?B?UzZuQUk5am1kdlRMVGR0bkU5NjRlRzBpb0NrTzhCaG5nSzBaYVRZeHNaMDkx?=
 =?utf-8?B?cmpscGUwMCtFdjNGQThRem5zRmEwc05VZXVTOEtwTytjS2tIemFsUjJkUEJm?=
 =?utf-8?B?R29JTGxGcElMRnNLWkUvdWZOQlF2SStVZjVuZzNKU3cvaGo5V3J4VVZGejdz?=
 =?utf-8?B?NjYyaWJyS1pCQVZFV3dTTDl3MDJ4MTlvODRDNDZhem1KamxlYlVCemRsbnNx?=
 =?utf-8?B?bEZsNkFwMXdoQUdLbFJJRU44S1J0MGh3WjBMQ3pvUEZJVFhrYXhPODhzMU9a?=
 =?utf-8?B?U1J6eUlhRWVZZDBYRk90Tmo3T1ZzWFVyZUhsZUdPNitvOUxOR0FCQzBsK25O?=
 =?utf-8?B?NHpFYnNzM0lrZ25mTnVLVjBnd3l1aXZ2ak54MEFhYVRpVzc2VmZjVzVVczRU?=
 =?utf-8?B?cGxIS01GbEtBNE80dXlnM0ZOc3RUTWo2WHJnNmovNVovUTByNmEwbEo1MDB4?=
 =?utf-8?B?dFo4L3dCaVNGRVRKN1F3ZExKbE1yVG1DazRmQ1o1UCtRN1BOT29KUWtvWEpH?=
 =?utf-8?B?SmIxcUJPVkhkRkxMa29tOERPVHZKR2N5Ky9NSU1KRDFaaVdnN0lkTGVoYjBt?=
 =?utf-8?B?Wm9YMUYzOW11Uk93QkxKNDdyQ0F3bXByUmdpdi9nTjRQem1uTldoZjI3bUxQ?=
 =?utf-8?B?b2JvOG9qVTdQOEFYR3prSitYUnI5TkIwWGo3dVMxOHBhSzFpWENVbEs5MCtL?=
 =?utf-8?B?WWlRZ3paejl6bzlGSGVmVjBCWkQxaDBzYUpvZTFaMFJxeDhuZzVDaURLU3dD?=
 =?utf-8?B?VGdsbTVoaXh6Vkswb2NPMjkzOTBnUjVISDdtTkJDQ3BUTzJhaWFueUpGZlVK?=
 =?utf-8?B?SFVuOUxYMmYySVBpZ3B1WnVnV2xYSXBqZnNpa3o0ZmNyMm1PM003OWtWSmtN?=
 =?utf-8?B?d2F4bjhMNC9ScmtVNnREN2dSNWRxOWpEdC8yQjRQbVBWanlDWGdYb3hVTDI1?=
 =?utf-8?B?bjNyZEI5MTdrcUNlUVB4ZjFoRW5jUWdLdS96cWIxbzNPcVoybU1wQzBmbDRu?=
 =?utf-8?B?cU91WklpL3hObGpGcmw5UGpIVjFQUFZ1eTViNzMxMjJMc09TeE13VldUYUI4?=
 =?utf-8?B?SloxOFdyVTYwek5mUmNFZ1R2QlN2RnhIaC9MdHc4VFFtcHZHVC9GWnVPWU9o?=
 =?utf-8?B?Q2x0cGpRRk44RHAyWmtiSnltdEhYbWNpLytGYW9icVdmbTdaeUJQclY3ckdv?=
 =?utf-8?B?VmJJTnUyM3FabjI2c1praVhXc0s3aDczdXVLOE4vUXJwWDdIUi9VSnlRVStW?=
 =?utf-8?B?OFVNcEhXNnVRY1lTeHU3eXlWV0Q2NllUSGowT2htUHR5TW0rOEgvdFp2ZUZY?=
 =?utf-8?B?MDBNS0RkbjdWZURwaWp5SDhsSGQrVFBYNWNRb3pZK3krbUNFeUpxNCtrSlpL?=
 =?utf-8?B?bWp2UTlpcGhqWkZlTjJWYmNCZ0I4S0dnM0lHTm5IdHVSNGJOYXpQMDRNblBP?=
 =?utf-8?B?VCtERHNlMTlsdWxqVVN1Q3VKM2VUeHBROWVQL3FMMUhKNXZLQlRNQVo1SzJk?=
 =?utf-8?B?cHBNM3BqY1ppcEN1a0hOdlRvNGpZNmdYQ3cwL01nWVl5MDY1djlsa2c2WHNN?=
 =?utf-8?B?MkxIZTBxb0RJN2V2d2dFN1l6Vjd5S2hXUHBEeHdHN2E0Mk1HcG54a3ZIRGF5?=
 =?utf-8?B?Zzl5WDArdTRPRTVndGJpdmhUVDByM3ZScnlxWU1hcVlZZzA4bXBHUFV4dndP?=
 =?utf-8?B?Q3czSTlMaWxBaFlHRkRiT3RtOXdONDZkeitOdXpJRDVoa0RSUllBSGVsMENq?=
 =?utf-8?B?SFZsV0JsK0g2QlRrSVRHU1JVQ0Nzeml5RGNaSG1uRytiekRsMkU2NjMvZWRT?=
 =?utf-8?B?RlEvM0NpK1hCVFhEcVowZGxNYURwZWorNlhFSXVseG92aVRDcDVqbWJkN2lp?=
 =?utf-8?B?WTRWSFAvRjgvU2hQeW5sQ2wxbG10NTRXOGZCZE1PbzMvRGRYRmN0ZTRTTDQw?=
 =?utf-8?B?TTZnVSsyN3F0VlhzVm82VEV5UExVQWtlTGtMQ1NHSTBGbG1Dc0VvRzlwQkJl?=
 =?utf-8?B?UmVtd2srQ3lscGg2NGN5Si9iS3ZLblk3eEkrRTdzL2dBUFJHWmNpbVBQVTlK?=
 =?utf-8?B?VUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62af0072-e483-4998-d5db-08ddeec3d396
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 10:38:19.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDGslkFImrgnc1h+a/RVMGvUTqJysGXC0zf7IhdR8mJtmHv1dxkPX3dNH7adO4LBd/Zs5RYE7BQUQtqVzCeT2vdyCVlzkNzOBJ/PZyPqgnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7460

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDAxIFNlcHRlbWJlciAyMDI1IDE0OjI0DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi80XSBjYW46IHJjYXJfY2FuZmQ6IFVwZGF0ZSBSQ0FORkRfQ0ZHXyogbWFjcm9z
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCAyMSBBdWcgMjAyNSBhdCAxNjoxNCwgQmlq
dSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBVcGRhdGUgUkNBTkZEX0NGR18qIG1h
Y3JvcyB0byBnaXZlIGEgbWVhbmluZyB0byB0aGUgbWFnaWMgbnVtYmVyIHVzaW5nDQo+ID4gR0VO
TUFTSyBtYWNybyBhbmQgZXh0cmFjdCB0aGUgdmFsdWVzIHVzaW5nIEZJRUxEX1BSRVAgbWFjcm8u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+ICAqIE1vdmVkIGZyb20gcGF0Y2gjNCB0
byBwYXRjaCMyLg0KPiA+ICAqIFVwZGF0ZWQgY29tbWl0IGhlYWRlciBhbmQgZGVzY3JpcHRpb24u
DQo+ID4gICogS2VwdCBSQ0FORkRfQ0ZHKiBtYWNybyBkZWZpbml0aW9ucyB0byBnaXZlIGEgbWVh
bmluZyB0byB0aGUgbWFnaWMNCj4gPiAgICBudW1iZXIgdXNpbmcgR0VOTUFTSyBtYWNybyBhbmQg
dXNlZCBGSUVMRF9QUkVQIHRvIGV4dHJhY3QgdmFsdWUuDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+IEBAIC0xMDMsMTAgKzEwMywxMCBAQA0KPiA+ICAvKiBDaGFubmVs
IHJlZ2lzdGVyIGJpdHMgKi8NCj4gPg0KPiA+ICAvKiBSU0NGRG5DbUNGRyAtIENsYXNzaWNhbCBD
QU4gb25seSAqLw0KPiA+IC0jZGVmaW5lIFJDQU5GRF9DRkdfU0pXKHgpICAgICAgICAgICAgICAo
KCh4KSAmIDB4MykgPDwgMjQpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0NGR19UU0VHMih4KSAgICAg
ICAgICAgICgoKHgpICYgMHg3KSA8PCAyMCkNCj4gPiAtI2RlZmluZSBSQ0FORkRfQ0ZHX1RTRUcx
KHgpICAgICAgICAgICAgKCgoeCkgJiAweGYpIDw8IDE2KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9D
RkdfQlJQKHgpICAgICAgICAgICAgICAoKCh4KSAmIDB4M2ZmKSA8PCAwKQ0KPiA+ICsjZGVmaW5l
IFJDQU5GRF9DRkdfU0pXX01BU0sgICAgICAgICAgICBHRU5NQVNLKDI1LCAyNCkNCj4gPiArI2Rl
ZmluZSBSQ0FORkRfQ0ZHX1RTRUcyX01BU0sgICAgICAgICAgR0VOTUFTSygyMiwgMjApDQo+ID4g
KyNkZWZpbmUgUkNBTkZEX0NGR19UU0VHMV9NQVNLICAgICAgICAgIEdFTk1BU0soMTksIDE2KQ0K
PiA+ICsjZGVmaW5lIFJDQU5GRF9DRkdfQlJQX01BU0sgICAgICAgICAgICBHRU5NQVNLKDksIDAp
DQo+IA0KPiBVcG9uIGEgc2Vjb25kIGxvb2ssIEkgd291bGQgZHJvcCB0aGUgIl9NQVNLIiBzdWZm
aXguDQoNCk9LLCB3aWxsIGRyb3AgdGhlICJfTUFTSyIgc3VmZml4IGluIG5leHQgdmVyc2lvbi4N
Cg0KDQpDaGVlcnMsDQpCaWp1DQo=

