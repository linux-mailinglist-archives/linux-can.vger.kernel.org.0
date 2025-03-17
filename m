Return-Path: <linux-can+bounces-3137-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A096A65138
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420C17A20EF
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9C23F424;
	Mon, 17 Mar 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VMDOpJ9m"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010063.outbound.protection.outlook.com [52.101.228.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458B23F43C;
	Mon, 17 Mar 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218365; cv=fail; b=HfsssyBurLLw/jdygg5c+ja6ZSae37BRRvIp7oEGO+gOJEQzinpaQCunYAtA55oai21FerMLH1RWjxIruVfh/NqRlxgbWPyr0WeI8L+gti6zja6OdFgqRkvlkbcSCKovLUf3bCMm/WMDrouQQ5qFUWmM6p9E1catE/o4Rm3gFJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218365; c=relaxed/simple;
	bh=ckRMDf0Kk+GVYY9/HJ2kNIzpdjRuB1b9Ia6dLYXQv/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WomzKqLS2fz/FLDJ4HYS7ugZ32LcEGb475p7kNeuiMeNN7deyEU24XSmps5XY6OBF9Si6rrOgE+G36vtMjPKgVIEBfs3jnMGUz34OigMAPFE6DvU3vTtX4r9NytlfB6cIdo3/z/P4AJYXak+MqVBoiUMiFBDhKP19vNSjE1sWME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VMDOpJ9m; arc=fail smtp.client-ip=52.101.228.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hncc286giZPdPv1IaNo46b8uDrCYvY6iEMJchH6aYBWYaMr4gGXCLWl56jeiJnSujH+Ao93w5pSYPLGNNgvuKMVS7FD/L62CUQGo+YoIb3uVAX3yDiY/oZVUfWoRd3sfuNMGvwU7MIOGW+OekZyqYCFlQoinQrkufCiD6Ew0SCnkbchJx+gGGMt6QYSsjYvrVAfZDjQ4PvLdM2nybmx3BEff3zri+bVUgpFPB7rOMNnh2R0VulO13J8+XeuM6x6w2x8sgwwsxKZ+SrZqKHK/rm+H03tVFAzD29UqD1O+C+uqEinDEatl/kdiIgsoT1EGurZvrxnssbkABHD3keZVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckRMDf0Kk+GVYY9/HJ2kNIzpdjRuB1b9Ia6dLYXQv/Q=;
 b=jbq26urvR0Rb3cRp/PC4zQfN0I6ZoSUomz+ImHjYj9F3G9GGMdqCnbfdTgvPuTPuMQAv9cB0sq7bv6P1cmpcCjlRmBe6oOYn3r8KeyYno2DunsA9+cViWEs26o7Hs6J2bVUWkZHw8ugNuku7XioBmc0nSxUHIg/wMXSxT2Fn+UYCVtilYHqzAdIALN2EgWnqN0CAsbJatTRqGVByO9XAWyvnsOTuGxrluJ4HyAnVS/sJBHGYY4nGzrS+iVmXFADKaJgw3E4f2PmSgKVniBalldQQaM6nAlesYS1rvpa/fn+1Eiu1k0b0z2AE4aVT7yhe4Yh4oJ3d60TlUblIk1SJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckRMDf0Kk+GVYY9/HJ2kNIzpdjRuB1b9Ia6dLYXQv/Q=;
 b=VMDOpJ9mcAvM7TFmbhE51V7FEY0TPt/s4nG8UrcXdvgvSLpinBcuUjQE+RxzzbNZw6kyk/sye5exBqFmjjSMzgXUym8V1QNAFo9WnpOcZEVc+3srIa3urBnC2xHVjb/6xq+8vqso5sE/uiOjMjA62AamFKWxJmJxa3cmzjYbRpY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB14148.jpnprd01.prod.outlook.com (2603:1096:405:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 13:32:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 13:32:37 +0000
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
Subject: RE: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width variable
 to struct rcar_canfd_hw_info
Thread-Index: AQHblzlGuhv0agutC0yRqgJG13TB6LN3SFmAgAACEuA=
Date: Mon, 17 Mar 2025 13:32:37 +0000
Message-ID:
 <TY3PR01MB1134685CB81B52D7717B3768186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-8-biju.das.jz@bp.renesas.com>
 <20250317-carmine-wolverine-of-discussion-a45336-mkl@pengutronix.de>
In-Reply-To:
 <20250317-carmine-wolverine-of-discussion-a45336-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB14148:EE_
x-ms-office365-filtering-correlation-id: 5d82fbcc-68d5-4b22-bced-08dd65582f18
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzIyYTdMWmlxSThtdTdJVk9meGpIT3lIcjI2TXd4YXZWeDExUUJuRlQzVWRn?=
 =?utf-8?B?YjA4aVd3V1lRNjh5ZDJhVTBTOFhlblNRZXdFREpGRlFubCtsM3JtS1lGd080?=
 =?utf-8?B?c2FYb2VhKzFaUUd1RHN5ZnlXaUFXYW5mNkFFODlKVTBJc0dIMXdpWmlCOUxU?=
 =?utf-8?B?YlJIM3U4UXJkcjFDY083NU5PdThqSGNVbndHelhrL2xlajZhektvNWRMNkVo?=
 =?utf-8?B?RmhKL3RrZU1QWVVVbEZTOEV2YVdZSnNCZjVaOVRTLzQ3clBNTTVMUHpsZ3hX?=
 =?utf-8?B?UkFuV2RUUlhhV1N1Z0FlbFhmVk5pR2krcElTMGl3KzFaZUthVklCSDVDa3RN?=
 =?utf-8?B?QmVpbk14MlFadlNvVS85OW0wUnFkZ2NKSytXMUhUR1ZpanlwUThVc1ZOREo5?=
 =?utf-8?B?Um9qUHNkQlZrektsbUlkR0JlM1cwWWNvQVdrK3M1OWVOSjBlQVVuRjdaMXF4?=
 =?utf-8?B?ZWVyMzc2ZUZ4OFN1Q291OWlEclRabERBcmUyRWhuVVZvamt4NVNpdTJ2eGlU?=
 =?utf-8?B?dFVMQ1hpb3EzOEN1TkZEZGZXOEhRU1F5dC8rKy96Vi9qeUFuNzdYRGVFclZL?=
 =?utf-8?B?UktBeTJnL2FzMzRGdlFqZDJYUU1TNjlDN2NCQ3VmZXZIRWl1T21MM0hFKzVn?=
 =?utf-8?B?SjczWVo4Q1VHZ09mYy8vdnhMZTRtdS9sNGJROUZiQkc4bXFLV2MvMWRQS0dX?=
 =?utf-8?B?cG5jSEl6TG9jMFg4bDJWSmorK2FlWC8ya2JjSVZZRmRaL2crc3cySU8yS2xE?=
 =?utf-8?B?N2RreU1IaldYbEMvTktFbjBreWpING9LaE1VY1FZankvOVIzem5lQTRiL3k3?=
 =?utf-8?B?YTVUZGZIcjY5d2FHTFNWQXJSN01GVnZCZmxHRWc0OFRQcmJBNm8xTzBEZ21q?=
 =?utf-8?B?eit1b0daa25yNzk3dmxjQXRoSi9raEJ5WjVHeThJMUhsdlZzVlpyZGFaUXVD?=
 =?utf-8?B?K1FPblVaZ1BTWndnQWkycVlWSTV6WjZiUjRITXE3cjFhZXFmVm1Gb3BCd2o1?=
 =?utf-8?B?Nm1YVUNEMG1mTGMrMnRrV3h2RnhiaDZSZUNSYVNCVFhNeE81NTliWmVvdzFa?=
 =?utf-8?B?TkR2U1luQlh4dnVsWUpqazFPWE9EOTU5Zkh0d3lyVE43L1pONis3RHlLcXRu?=
 =?utf-8?B?ZldCTkhveUhxK2FZT3ZtSjRNS2ZmYWYyRjZYV0xXMmppbmMvRk52dmhpZTRW?=
 =?utf-8?B?WUtncVM0VVJnZmNhNlVsWktncmVBbmtBVzNadjBqNG96cllhTGRMQ2VXb0hp?=
 =?utf-8?B?RHlJcTAzbXZpaE14NTJnWmxSRGxVb1A1WHVHNk1NNUk4OER2UXBKSjVlTGZB?=
 =?utf-8?B?YXFzMU5SNXBrc3F6OTJSWXdrbkNvRjltWEIzaFFGZEJGclhLMndRRFhUMFd6?=
 =?utf-8?B?ajNZU0NPWEFtSVBoODMxWWhkbW1xYXNxVThHMzhRZTZlS2JSeWYweWtEYVBk?=
 =?utf-8?B?WU1lQ2ZUWE51MXRNNy9DOGJiemswbE9YWlhjZ2RBTG0zY0Uwb1JqSFdVKy9y?=
 =?utf-8?B?Ly9QczZWcGtwcjlqSFRISWFwaUlQWmQvcjlheDYrTytGcVdxVzBFaVFpY3FN?=
 =?utf-8?B?UDBIWG04NlJmUjFER2VsVDFDR0xFSDNEdjQyQmRHWEloUlludUZCN2pCNU5m?=
 =?utf-8?B?Rm45R0ZsdUc4czRlUzJ1YTNUZlFGTkdXRVF1VnBIdXlKV1NvR3QyRzB4aTh3?=
 =?utf-8?B?cnMxRDltcGcwcTlOMEl5SlRBU01aS3FJSE53MFMwNmdMRmZ4S3kycmVTcmlH?=
 =?utf-8?B?U3gyMDNwdEdlQWg3Nm9TeFBYdDRuQng4eFN0bkdnMWl0ZUtVeE9iVlJ3eDk2?=
 =?utf-8?B?RlI3S3BudDBBU0dZRmtSUXdYdnFGZ2NjWkVWczBJRHREU2pWMmJnbGhlVjQ1?=
 =?utf-8?B?REFsbWxoVGhpb1VMNGZuYkZKeTlvSmVWUXpNaVB6alpOcnVIdHg4Q3lwZjls?=
 =?utf-8?Q?Sd+acbv8SvcpFsYjDlhm2jU9W/L8w34q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2dXZ2RaLzFGWmk0bUw1dEdXcHlsWnhYVXo0blZ1WEF2eXk0ZS9zU25hYmE0?=
 =?utf-8?B?b1dSSjRjb3N0b3FveTJUT3B2cjVrSTJpUmRFYnMrR3lWaHRkd2Q0Y3poSXdY?=
 =?utf-8?B?NUZpNUhFWWt5V29YNjRMUk5EVUswLzZyMjhMYTVWbnFKZlUxQlYycTZLZHlO?=
 =?utf-8?B?eWxRbmozL21CRkppV01kVVBNTC9WUmNPUVpsM0gvU1gxL2NIZVFNSkh6d1Zw?=
 =?utf-8?B?L0w5ekpmSCtQc0JaMVZZQjJTVlVWV3FPa2pyYlhXQ0k4RTBlLzcrL2hjS2I4?=
 =?utf-8?B?UXRtcjI1Zmt5bEZ1S2k5R04wRFJQRXhqbjVSMDUvVnZ4eVQxa1VUN1JEY0hV?=
 =?utf-8?B?b2pPRGJ3NjFmdkVBb3ZUSlE4N1V0SEhiM1V4aDVaVXNIc3VBM3o1dURLcERK?=
 =?utf-8?B?OUpBZTRIdzVDN0R2Ulh5NTAyYWhXSzJCTWZSWlcrSFJ5TjhqRjdkQzlvNzg3?=
 =?utf-8?B?SXdVa0FZaVZoV1JmcjJWd0RIcTh4YTlwcENPYlBQeFlPMmtmYkViYUdrellr?=
 =?utf-8?B?VlVORlpwd1hRc3RKUTM4L1ZwdzNlUUxIcGU1UFpmeVk0ekRDZDVlQSt5Qis4?=
 =?utf-8?B?ZzNHZ2FFM3JyeDl1NkYvQnh1L1ZEeU9tL3lFb2p5d0dHRkh6VFVFaXByWE5p?=
 =?utf-8?B?dG90cEV0MDJUOGtKYnFNbkZOQzhZWnIyd2VvMkpSSGxEWEpFSVl2MThxQ1Fz?=
 =?utf-8?B?YnRYbXJsMVo5TWJEY2V5SHVqRk5CSFBYSlFVNUllMGg2Y3N3eHFkZHBTSDZP?=
 =?utf-8?B?ZUFiQ01yUjB1eldtMElHRnlxZ3BOQWxYMDVNQkV4YUJHdStjekFZLzdhMnZK?=
 =?utf-8?B?bXdNWThoSzJ3bHJjQ21LeGsrMyt2K0hYdTRudkdKb0cyTVlqWDNlQm9WR1Fk?=
 =?utf-8?B?Y3FDaWk5YTZ5WXhUVERLalU2d1oweHBGcVBCVlloNmtBQ1J3V2U2dE5KQjV5?=
 =?utf-8?B?bG1uQnIwdWVHWkFNcXRQOVFNb0NnK2pYQnlTUFRlMnNZUnhqZVhxSlhxaG14?=
 =?utf-8?B?WWtrZ2NNOWVhTGx3V1pRTUVMT3B1NHQwckJPMG5JMnFDU1BkZkkzM3pvVm1r?=
 =?utf-8?B?cEhRdStTcTVpMzdzZ2pBaXJ4cndPNGlwcEZwQ3I0a29JZ2JSQyszMS9MRUEx?=
 =?utf-8?B?K2VHSy93MlJSMG1FUXJpeVByWlZNT25aM2s5SDRjZ0NnbDBpaWRoT1pIMDBo?=
 =?utf-8?B?L28wRjVWY0R4RlFkd2EzRjZFbUJ5L0FsRkNXVWgxejR5VmJpV3FidFBCbS8w?=
 =?utf-8?B?WjdLdFVmTW1pMHpDbEVWWEo1TkpzaHA4bTU3QjZlOFV2azBzQlpXM3RWOUNY?=
 =?utf-8?B?VWgwcTdtcDNseGoxWWdjOFJZdWFvODFDU09kYUUwb1NyQ2k4b3dHR0t6bFp3?=
 =?utf-8?B?UWQvblhFZ3JNYW1GbjRBMFM5dlVzK3hYa05OS1hoNDFqWmQ0cjBHa3F3TDlk?=
 =?utf-8?B?NHIzd1d5U0sxSm1JRW1OTDU3OVBaQ3BKK0lJSmdwMmhJRlZQNytraG1mYmk5?=
 =?utf-8?B?a1lFRXVrcjF2RnJ0TXFyZ3d1M0Z3RldOU2FJTFRERVBuVWJiVFArWDlwSmt1?=
 =?utf-8?B?TE1LK1JWQ01rY082d29LMlhKNHZ6K08rRU04dFVGK0xiT0lLMXJuNlhETVpI?=
 =?utf-8?B?RHphczY5V0xBa3pOM1dBV0J6dDNueXJYUDFrdzJMLzlWVGNscjAwMHhzeVJX?=
 =?utf-8?B?cWVCN0NUZGVlNldpZ1pSNmxmQkxXVUpBanpoOWZBcE9IRFBoYnVnRDQzQVFt?=
 =?utf-8?B?ZzFCb3daYXdaQ2RvaldJTmV4aTZ1ejhhbkdsa29rcGpEaCt3ZkhkbDEzcmVQ?=
 =?utf-8?B?NDYraENZYlh2OGE0WEwwdXcydW81VXNscE8vdHZlUnVTUzhhaUpCQXNLY3hl?=
 =?utf-8?B?enpSb2lDdWJ5M0h5UEg3Z3JGZ2twejVmNEU3UTdxOWFuMWxXL3RGMFpQdEZT?=
 =?utf-8?B?UTdZWHVJeTNNOElzUnFKajJlbXdXOEVVbmlHekVCVUpjUTh2cG9KZWN0eDM2?=
 =?utf-8?B?NnpTd3FTcWN5elE0MEhNK25MK2ljQ2QxUGVBMktYMkV3ZEt1c3E2VGNKRVVw?=
 =?utf-8?B?a0Y4TVJLVlgrdkp4bDM4T3dqdTF4Wm5SanVEWmYxQm1CWnMxTjc4MmdQc3ox?=
 =?utf-8?B?ZGhrRkgycXdCMkVub0Y3STRPN0VPZzNKS3h2Z1JYQmMzTkNtaklEWDQzejlF?=
 =?utf-8?B?UHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d82fbcc-68d5-4b22-bced-08dd65582f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:32:37.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXDKTWIlt07007Dar8v4+PT2A/+kIQmWNjSnJdim/Y5Fmgo0MvgnaPJFNKzOysWiCIXDuZc8TB1hXepIA57VqQien2lC0uFa5Zo8upfr/a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14148

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMTcgTWFyY2ggMjAyNSAxMjo1Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
IDA3LzE2XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBybmNfZmllbGRfd2lkdGggdmFyaWFibGUgdG8g
c3RydWN0DQo+IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiANCj4gT24gMTcuMDMuMjAyNSAxMjozNjow
MSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gUi1DYXIgR2VuNCBwYWNrcyAyIFJOQyB2YWx1ZXMgaW4g
YSAzMi1iaXQgd29yZCwgd2hlcmVhcyBSLUNhciBHZW4zDQo+ID4gcGFja3MgdXAgdG8gNCB2YWx1
ZXMgaW4gYSAzMi1iaXQgd29yZC4gSGFuZGxlIHRoaXMgZGlmZmVyZW5jZSBieQ0KPiA+IGFkZGlu
ZyBybmNfZmllbGRfd2lkdGggdmFyaWFibGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyBh
bmQNCj4gPiB1cGRhdGUgdGhlIG1hY3JvIFJDQU5GRF9HQUZMQ0ZHLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0K
PiA+IHY1Og0KPiA+ICAqIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvY2Fu
L3JjYXIvcmNhcl9jYW5mZC5jIHwgOSArKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+IGluZGV4IDMyZDcwMDk2MmQ2OS4uOTI0YTExNmNkOWFiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC04NSw2ICs4NSw3IEBA
DQo+ID4gIAkJKChncHJpdiktPmZkbW9kZSA/IFJDQU5GRF9HRVJGTF9DTVBPRiA6IDApKSkNCj4g
Pg0KPiA+ICAvKiBBRkwgUnggcnVsZXMgcmVnaXN0ZXJzICovDQo+ID4gKyNkZWZpbmUgUkNBTkZE
X1JOQ19QRVJfUkVHKGdwcml2KQkoMzIgLyAoZ3ByaXYpLT5pbmZvLT5ybmNfZmllbGRfd2lkdGgp
DQo+IA0KPiBOaXRwaWNrL21pY3JvIG9wdGltaXphdGlvbjoNCj4gDQo+IFJlbmFtZSB0aGF0IHRv
IHNvbWV0aGluZyBsaWtlIHJuY19zdHJpZGUgYW5kIHB1dCBpbiB2YWx1ZSB5b3UgbmVlZCwgaS5l
Lg0KPiAxIG9yIDIuDQoNCnlvdSBtZWFuIHRvIGRyb3AgdGhlIG1hY3JvIFJDQU5GRF9STkNfUEVS
X1JFRyBhbmQgaW5zdGVhZCB1c2UgLnJuY19zdHJpZGUgdG8gc3RvcmUNCnRoZSB2YWx1ZXMgezIg
LCA0fSBhbmQgYXZvaWQgcnVudGltZSBjb21wdXRhdGlvbnMgKDMyIC8gcm5jX2ZpZWxkX3dpZHRo
KT8/DQoNCkNoZWVycywNCkJpanUNCg0K

