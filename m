Return-Path: <linux-can+bounces-1431-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA996FE81
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 01:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D5B2331B
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1315697A;
	Fri,  6 Sep 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="G15aU5Rs"
X-Original-To: linux-can@vger.kernel.org
Received: from us3mail02.teledyne.com (us3mail02.teledyne.com [130.50.171.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D615B12D;
	Fri,  6 Sep 2024 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=130.50.171.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665587; cv=fail; b=K96HBX1hRW6O1kcvidGkJVXXt5TUVWpHh+2+Ldc1pITXSBM+YUjoOjegKhijDu2jj8bYl8/XbsvxYRJA/f7HnJcUtx+j6bUu6hR4bs+GeZ2dHUVDX2z22lzY6PAWKAKMS+LqmKccIOSSBvokw5Nq7TKJd/8V3TRXzj0Mf5CkF1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665587; c=relaxed/simple;
	bh=qWFXcOIzWesw5wOBQr7ZN/Hhw8Vv01LvWoAwSTgwSjg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXLSKPQEH/vqI/IAldUJqtRbRLaxU6gWgm55nEXmlq/wHDoPcKq44wJGtz48qUUVkt7yiFGNcZ3gO76vFsOivMfuIfIraoTJeT+32SgtPbuKGDdTaQ9NESmTMGd5Qkhv/3DMLLR0EkZPxsiqv243hl1k4NLH5mvpt9/Sr259Cf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=G15aU5Rs; arc=fail smtp.client-ip=130.50.171.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725665587; x=1757201587;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qWFXcOIzWesw5wOBQr7ZN/Hhw8Vv01LvWoAwSTgwSjg=;
  b=G15aU5Rs+OwjNBM1xEOxCRayUWpOWq3wjXlGy/TPhtN7Z0yDiqzuN1nj
   fRxUCb7j2oO5jIPWVnR/FbqMrbnkbApnzKjYMtB87ceZtrg3Pxz9YpfXx
   cNX6gTCWZ7sJZJJcRhPQN8gA+GeGHdhoH1LSzzRAt0tZqswf95iBp8tun
   lCM8zUU99UnHFk5JVdLFbVFHbRVSqJyiAHaY+nYQcq2Ut5zFgL0tReYaG
   IQFf2uuvJC6VDOhvTn0PMd/WBqvbd8KDzrphdTwBbereP9q94B7nrxgDK
   bV7vANLwwIrPqV/SInQaFP1fJI4oq9C1q0BcMoMItsYrm1s+bol4lwmWY
   g==;
X-CSE-ConnectionGUID: xtvT4+bxQWKyk35nkNA9NQ==
X-CSE-MsgGUID: 0zZtkD3jSfC0/ahxIbiydw==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:Se75e62MDWCNPclDdvbD5alwkn2cJEfYwER7XKvMYLTBsI5bpz0Pz
 GBNUW2OPq2NN2b9e4wga9i19ksGvZbcy94xHlZlqSg9HnlHl5b5CIXCJC8cHQvLdpefFBo/t
 63ySfGZdJpoFieE/n9BFpC78BGQAInRHuKU5NbsY303GEk9Dn981HqPosZh6qZwm9+1HgiRj
 t37pszbKTeN1iV9Wo4uw/vrRC5H55wehhtJ5zTSWtgb5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXxqZwChw7id/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85eeSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5nHX9yq
 b8SOAkyTQGA3L+ww5SSG89V05FLwMnDZOvzu1ld9mucM84Der+GZo/6vYYewDshwNxDGfvSd
 swULzFoaXwsYTUWYQ9RVcp4xrv1wCKnG9FbgAv9Sa4fwWHQwUpR2b3nIfLJd9iHSdRTkwCTo
 WeuE2HRW01HZYbHk2Temp6qrrfdrz/4dNkQL7OTrrljgE2yzG0CBAJDADNXptH80CZSQel3L
 00S5zprpqE03FKkQ8O7XBCipnOA+BkGVLJ4F+w89RHIyafO5QudLnYLQyQHa9E8ssIyAzsw2
 Te0c8jBGCc19aONTGmSs7KevWvrfzQZPCkeaCsJQRoD7p/op4RbYg/zc+uP2ZWd1rXdcQwcC
 RjTxMTir93/VfI26pg=
IronPort-HdrOrdr: A9a23:Auz8qKmUvKUAYqOZSeWtNh6xLF/pDfI/3DAbv31ZSRFFG/Fwwf
 rOoB1773HJYVkqNU3I9errBEDoexq1nqKdirN/AV7NZmXbkVrtBppl6s/PxCKIIU2OlZ8+pM
 IQF9kYNOHN
X-Talos-CUID: 9a23:gB/zcm8dDtHC4daP3dWVv14IBPx5MXfN9UjzMkzjVGBqbpTEb2bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AZ80tZAyaQyt2f2MLsTCjev6XW1aaqPy8OlwOvc4?=
 =?us-ascii?q?EgMevbWt5Oye8hjWmTpByfw=3D=3D?=
Received: from us2-vpmsg-mbx01.tdy.teledyne.com ([130.50.245.30])
  by us3mail02.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 16:33:06 -0700
Received: from US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) by
 US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 16:33:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (130.50.245.239)
 by US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 16:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HunZfm8P7EAdGASMPLJcpmETCDiN0y/eEKHzSkBrTdxdljRclys415fFN8ELc140o4w9xApc/s5UiuJLcZSAi1eBfB/ay2cjBEQwLAjwoPHthGHcgip7na6tD64jArv2HwX0L5KKvzoMn4dj02irhf2aCR8qmmJEC9HeEGu8Zyfs64jroQvZi8ZJn4SuK6rKx4Uqs+w55XCOJWpkojjmBCjA+fZHvdSmJV+MTFL8UmgSbmb8mykDRe2b6TcXFsNzthUnCz53dli+70PcU0aE1VouGTSNnD+7YMLN0r0KGAPMsPQl9i2AUzZOj5NcJ6hzJ+PSK8DXzDYQrnMp1Rua5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWFXcOIzWesw5wOBQr7ZN/Hhw8Vv01LvWoAwSTgwSjg=;
 b=hkIE2Twfwt5+ypOSY7tjHv14Ckw5cqv23vTvAInJ0YqIokSPW2ytOYXJ7FuhDeDSOaSJzB3QbkiHdzL50Ap+1HG0Xq0ufqWuyVxJsaaortZxgg5/jN9RXqBL0Z5H2G8H3s8FvNtGl4lxWTisBV1drUawuRQSAOX+IlrT3W28QqTH8cKfztPgwzFdcJWuZ7ANeFw4VhkndT6woPpHikMcvYUMqM4kxr2UdqY7yXCYnbaDbOwlkX8NoFGoC6Z0ZqRoDqT6J/CUud/MjnHDT9pnUfv7vJ/OATxslApFYLI3wFoDlNX4gsV2Xvv60VLvxcasSCxjYsxyFpcMtc38/ZBcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 DS0PR14MB7048.namprd14.prod.outlook.com (2603:10b6:8:122::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 23:33:03 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 23:33:03 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAsyKTGmJ+XkFHSO22ELaGzk/2HwAAXw+g
Date: Fri, 6 Sep 2024 23:33:03 +0000
Message-ID: <DM8PR14MB522160BBE4C6BFB2FC6AF4D2EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
References: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
In-Reply-To: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-titus-metadata-40: =?utf-8?B?ZXlKRFlYUmxaMjl5ZVV4aFltVnNjeUk2SWlJc0lrMWxkR0ZrWVhSaElqcDdJ?=
 =?utf-8?B?bTV6SWpvaWFIUjBjRHBjTDF3dmQzZDNMblJwZEhWekxtTnZiVnd2Ym5OY0ww?=
 =?utf-8?B?Wk1TVklpTENKcFpDSTZJamhoT1RVeE1UVTRMV05pWkdRdE5HTTRNQzFpWWpF?=
 =?utf-8?B?MExUQXdaRE13WlRJek5EQmhPQ0lzSW5CeWIzQnpJanBiZXlKdUlqb2lSVU5K?=
 =?utf-8?B?UkdGMFlTSXNJblpoYkhNaU9sdDdJblpoYkhWbElqb2lUazl2Y2tWQlVqazVJ?=
 =?utf-8?B?bjFkZlN4N0ltNGlPaUpGUTBsS2RYSnBjeUlzSW5aaGJITWlPbHRkZlN4N0lt?=
 =?utf-8?B?NGlPaUpGUTBsSlZFRlNRMnhoYzNNaUxDSjJZV3h6SWpwYlhYMHNleUp1SWpv?=
 =?utf-8?B?aVJVTkpSVUZTUTJ4aGMzTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2libTl1?=
 =?utf-8?B?VlZORGIzVnVkSEo1SWl3aWRtRnNjeUk2VzExOUxIc2liaUk2SW01dmJsVlRS?=
 =?utf-8?B?VU5KU25WeWFYTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2lWVzV5WlhORGIy?=
 =?utf-8?B?MXdSWGgwSWl3aWRtRnNjeUk2VzNzaWRtRnNkV1VpT2lKT1R5SjlYWDBzZXlK?=
 =?utf-8?B?dUlqb2lRMjl0Y0ZObGJuTWlMQ0oyWVd4eklqcGJleUoyWVd4MVpTSTZJazVQ?=
 =?utf-8?B?SW4xZGZTeDdJbTRpT2lKSmJtTnNkV1JsUTI5dGNGTmxibk5OWVhKcmFXNW5J?=
 =?utf-8?B?aXdpZG1Gc2N5STZXMTE5TEhzaWJpSTZJa052Ym1aTVpXZFFjbWtpTENKMllX?=
 =?utf-8?B?eHpJanBiZXlKMllXeDFaU0k2SWs1UEluMWRmU3g3SW00aU9pSlFTVWxFWVhS?=
 =?utf-8?B?aElpd2lkbUZzY3lJNlczc2lkbUZzZFdVaU9pSk9UeUo5WFgwc2V5SnVJam9p?=
 =?utf-8?B?UTFWSlJHRjBZU0lzSW5aaGJITWlPbHQ3SW5aaGJIVmxJam9pVGs4aWZWMTlM?=
 =?utf-8?B?SHNpYmlJNklrTlZTVU5oZEdWbmIzSjVJaXdpZG1Gc2N5STZXMTE5TEhzaWJp?=
 =?utf-8?B?STZJa1JwYzNObGJXbHVZWFJwYjI0aUxDSjJZV3h6SWpwYlhYMHNleUp1SWpv?=
 =?utf-8?B?aVVtVnNWRzhpTENKMllXeHpJanBiWFgwc2V5SnVJam9pUkdsemNHeGhlVTl1?=
 =?utf-8?B?YkhraUxDSjJZV3h6SWpwYlhYMWRmU3dpVTNWaWFtVmpkRXhoWW1Wc2N5STZX?=
 =?utf-8?B?MTBzSWxSTlExWmxjbk5wYjI0aU9pSXlNeTQyTGpJME1ETXVNU0lzSWxSeWRY?=
 =?utf-8?B?TjBaV1JNWVdKbGJFaGhjMmdpT2lKRlRVWjVRek5aUlhabWFtaEhibTVxUjBw?=
 =?utf-8?B?dlZscHRlWFIwTjJsdVRqVTRlVkZ0ZGt4RWNEQm5Wa2RvYzJWd1ZtWk5jMEpV?=
 =?utf-8?B?WEM5Q1Ixd3ZTa1pWUVZCQ00zTWlmUT09?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|DS0PR14MB7048:EE_
x-ms-office365-filtering-correlation-id: e5c31c2e-4c3b-40f7-4eda-08dccecc408f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0ZvRWlSaVJxbVZmbnZSZmVPb1VnOTh3MlM0d3VjK0wxVFFiYUhuMHFBdjVQ?=
 =?utf-8?B?SXpUN1VxTXZjeXQ3SEhJM3JmRUhHNXZVTkRHSFlpWmYyYXVLS3ZEcTVqVHNK?=
 =?utf-8?B?UlFTRlo4eWFDdUNaNEtxQ3N4MTE4QVVFdnEzQnJsWDRvZWs1Nk1mUUhSNE5V?=
 =?utf-8?B?czBkSmFqQ2lJMW16QTd5SVhuYk00RGtzWFVQUGhxRGwwMUhXWnVtNm5Ld3Qv?=
 =?utf-8?B?WGhEK1R3UXVBTDJzWHFnb2xOSnBOTGRuSE02UHNlR1BzalNQSlMwalBzOXVl?=
 =?utf-8?B?ZGNSNnBvMm9JZU55UXUycXJGYkFIb0l2SVZIS0pJTER2eDNiZVRtdklUaHRz?=
 =?utf-8?B?UFlSQ3gvck93dExQNktrNCtWeldzNVpabDFVdkViektaVWx0NTRMN3ZWWjNE?=
 =?utf-8?B?WGtYWjY1cWFWcUJhR0xjZTFNQ1EweHhiM3ZMT2tUNFd0ejBzaXN6TDlxQzIr?=
 =?utf-8?B?bmJJbzQzdG8vdEJrMktzcnBBZWJVMFZnQ0REY24rRlhKRDk1b3lPY1d3TGlU?=
 =?utf-8?B?NityS2RaTUR3N1lzSmVhTzdCWENBK2VBekZENU41NHRpb3FvaEFoTjR0cWgz?=
 =?utf-8?B?K3RscVNBYkNzRXVhK0prRWo3dmVZbVZtdHBtNUxqRXp4U0xKZXVRM2g2NDN2?=
 =?utf-8?B?UmVQRDN2QVdCRFpvQnFtT3ptNkYzRWp5RXExRFRXQkcza1ptaWh1UmJTRWxv?=
 =?utf-8?B?QWJ5Wk4vbFVQSVV1akdra0VYS2E0QzFtRTVhZVVKR0wyc2dJZnNaS0N4OTRJ?=
 =?utf-8?B?OExrNXhlTGN6WVI1cy9vVGxSdTR5eXloUTV5ZHJIUXUwd2IyVDBEVzZRTStx?=
 =?utf-8?B?WjdQOVVmU3YvV3UyNzJuL3pnTUFyRUx3NmFQcUJpWWZJZ0dJWG9OUlp6K2lG?=
 =?utf-8?B?MldPN3c5ZWFIbmpuYWxxTnEvTmk0NVZCTjQrbEVSWndZL2JFOXFyaFRob1Jp?=
 =?utf-8?B?SnduUEpnWDk3MXl5YkxybUtmV1Nmd05NanJ3TnZXdisrdjFwYzJhTGhIMzRP?=
 =?utf-8?B?OFZwRS9hN215emFlMHVsZjBRV2RobCtZRkFINytaMGRYeEMxTmVMb0xIZi9X?=
 =?utf-8?B?NWZrUlhHT2dNcEVxeStOSFdJclZEczV5SHcyZFU0cFpyZUZac2N6OWlZbldr?=
 =?utf-8?B?VDFqVWN3aDBxL1cvVVRTc2ZpUkRPOVA4Q1g4dFl3N3FSWStwYjAvSWJpbGVW?=
 =?utf-8?B?cXk4VTNDWWR5Rmlpc1Y4bnhQZzdPM2JNUnhCUVBzcXE1aUdsSjM4WVFoNFhY?=
 =?utf-8?B?UDF1LzBoTFdaTVZsam9HeWY3WlFjV0RySGJ0MEQ4bk9kbEF0TTZpTVU3M1Nw?=
 =?utf-8?B?a0ZSNnY1aGNNa09pQ25yOFg4TnY2SlA2L1Boa1gxMkpBSGlLMGpQSFhMazQr?=
 =?utf-8?B?cFpHQ2dOeE1oQkU4TFBPK2hZdkxvSDE4MEhXRkFWSXkwM2FDR1Bzeko0ekp0?=
 =?utf-8?B?YzhuNXBlVEZ2cUx3c1BrbnN1Z1JiRHp2a252MFJKa3d4WFQ0YTBIODBSN0FS?=
 =?utf-8?B?ZGo1bGV5U0U3WnhqSjQwZ1pPc3o2aW5tYnFTTmpCU3lpMkFNY2wzcmZOalBE?=
 =?utf-8?B?MFpIak52ZWc4d2Ric2RFaFc2TmhuTjRabmFoanFqUmxhRk9sNDRNUUZKMnEv?=
 =?utf-8?B?Y0xkeFZhYkloa0NKdEJ1NHNWazhSVkdzSVNFeDlYaWJGZ0c2ZFlLTlEyTXRs?=
 =?utf-8?B?Zjk5SFJLSGdCMXRtdDg5SmtHaG1QRWdDZ2tpaGZvZXVEL0RjYUc5WTlmYXh2?=
 =?utf-8?B?TnhmYU5vdXF1WUl1cEtrK1E5aDd1dFR3VitUelJML3FhbkFmVXRSYnFSU3d4?=
 =?utf-8?B?citqMVJTQ2pPSjhsWDVwblJuRWhNVWphT2FhbER5QjZGL0QyaWh4SXhuc1Z1?=
 =?utf-8?B?RW8ybHI4TjVtb1NKMjJFRXdVMUNlcjlud3htL2ZGS0lpaFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXpwQzZ2NlE5MDdranozaEYzcDRQM2xWdGRDUXdtbnFkWW5yTjlmcXJsbnhw?=
 =?utf-8?B?a1Fhdm5HbURRaFRzeEtnbGV3aWlwYVJMZnJ3Z3ZJQVdLWkxiQnptNGxhRElu?=
 =?utf-8?B?UHNQVXE3MGdwNTF6VTVUa1lwRDlUdnNlbENrQjlGUCs0OGlzWUFZY0ZDa0FI?=
 =?utf-8?B?TVFpZzFJZmhPMmRIZnNTc0pkcWxFSUZjemV6dk5IdmNUa3pGUk02bFBxUzlo?=
 =?utf-8?B?MUVyYnNMNkZwYllrU3JGVCtRZUtuL1llZUJtRENvaFlKQkRaVGJkN01YaVJ5?=
 =?utf-8?B?QVJVdGpTZGxVTHpNVDUwalJJRDJMUWF0ZlhFQnc2TDVkWHN0cnRueVI5TWlU?=
 =?utf-8?B?RWtwUlM2aEpNekZIdXNqVFExbXcxUEFOSDBTRGwwTkxrL3U3WVNLQjF4NWZV?=
 =?utf-8?B?c3d0NjRIdnNUR1NuaEYwQzkzWElUbkhSUVlNRlYzdUNBN0YwM3Z2aGNQQUF2?=
 =?utf-8?B?UmY2bk5taTlDc0o3NEExZHFHcXhDV3VrNjF4YlNZVEJ6Y1BQR0k0YlVmdFg3?=
 =?utf-8?B?R2xDcm5qZzBkMlJzNnp5M3VjanpHcHUrUGp1ZlRCZCtXOTVRTHJxQzd6TGNQ?=
 =?utf-8?B?MmVIa3YyYitYeW8rV2U5dThQSjU5bGVQL0toLy9jQ2Q0ejg1cUpvSGNUQnFl?=
 =?utf-8?B?MG9xbk9lbUJJWVJFUHl1SjRpOUwybHZ0eGRZMkxZQ3BkQ0pWampZdWZ3eEUv?=
 =?utf-8?B?OUFiVUNzYkZqM3pHQXpRdCtjTFdCK1FKdmFNMWxFNkxpR2s2dE10Q05CU0ti?=
 =?utf-8?B?ZTY5dThkVURiNktOUDB6dkpnNlpLd1h5NXRiK0l6OEJOYlh0RUJtSHBjdEZX?=
 =?utf-8?B?bHFtUXg1TkVaRFE3MVdkbDg2QnFlUHJUV0hIN3pBaGI0SzVuUi9wdXVGNVdj?=
 =?utf-8?B?V0NoN21HSXh2cjc5RUVxWWhQaWRTTS9DNFdYUXgzc0NYMmxuUllzMnR1T3lS?=
 =?utf-8?B?NjRsd2c0MG52L2F6d01wVEd4VkhXSDAyc3c2UDVIU2kwVWRKZVdpaVNMS0Nl?=
 =?utf-8?B?QXlxNkJvY2cxblpsdUhtaEsyRFh6ZWswbXYrblhoZ01ucUM0ckVUQ2F5Qm5H?=
 =?utf-8?B?VktuWUFGT1BUWnhjYkVWbUpVMGdMMW1FdUd0LytJbTJ1SVNraVdmV1FvbHNL?=
 =?utf-8?B?UE1iSDhUVDFLWG9UUjJEY0J3b0VPZnRkd2ZPdFV0VW9WdlNsSWJFWHU0TDE2?=
 =?utf-8?B?aGxpbm95b2pIbDRHMm9Sb1pMWVhPRnU2YU5RK041bzJUTEprdEszdGp6UVp0?=
 =?utf-8?B?RnhCREhSeXlkOVFoMllmdGV4YmFYWXJaaHVSZzBWUFdINW5CMkw3ME1hTVNV?=
 =?utf-8?B?dThsdnR4aDJ3RTBaM2RONDN3VzBRZ3o5Q2N1aDBhU2dTVXd2eVZIQXcwSVdN?=
 =?utf-8?B?SUdMYnB1dDhZMFBIQy9GZk1sTGNFVzhmUEFmNW1wK2kxK3hTU050clpaYVdh?=
 =?utf-8?B?UnkxVFpDR05HYkhXdWE0M2w5NlRrT2V0SFQ5TVZLZEdUVUlaMFZPZm5YRE9W?=
 =?utf-8?B?NVlLakIzUmFneUJSaXY1U2Rja3M1Tllqa0F3UGxIWXh0N3ZsM3pjVWNVRkw0?=
 =?utf-8?B?K1dscWw2cXhLQkJnK1RVQStWdTNHQXovR21kT0VueDM0bUtPN1FlVHRYd1U1?=
 =?utf-8?B?VjR1b1YwYitLNzNwRnNVWm1NcytDM1Q1a1NnOUM3NGVEK3RwRmZpNFFnZmpk?=
 =?utf-8?B?dmdKV01kMjZBdFlZdlpWS0lSYzVjbzNCRnpTWFljbndqUmRIdTFRaWovSkxH?=
 =?utf-8?B?ZFMvNFNaN2llUFVtaFRDb0xjclhnbnVMNnRUWEt5YzJnTnBtWjk1R3k5SzdU?=
 =?utf-8?B?akN6QmZIeGpqcTBhRzNTUTc5RTBsa0ZJS0MwUldQWHpXaVVmalh4N0ZIelpS?=
 =?utf-8?B?U1RkTEU1RU1xcEhHSFZSREMwbXQ5MytlMmlDQ3oyUmVLWThha0JvNDFQTTJ6?=
 =?utf-8?B?MlJEWWN3UDE5WE9NNlBob2lBTFhkb3M5YXRhdnI3cFI3SVhGSWJkcng1Z0dj?=
 =?utf-8?B?cnVEUWwrWnBCQThlNFdZdHlTYmtLbDU0UWh2WG53TVRuVHoxMENrZXUyZi90?=
 =?utf-8?B?ZFVBZUdlbk1wUEs1RmxxNi9oRExoVWR4ZkxYRVQxenhDREczR2FGMm1pRkl6?=
 =?utf-8?Q?PXY8RlrZx56+GvCMxX2z6ZNKm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR14MB5221.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c31c2e-4c3b-40f7-4eda-08dccecc408f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 23:33:03.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/j3cJ3wwpc9IWZi62ws2Oy7Kbe3O5HQlIINImWvGC4hp06W25htnSBJwBfklGVjMthO5vWhi2B9uYmcwfvd0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB7048
X-OriginatorOrg: Teledyne.com

PiBJZiBhbnkgZXJyb3IgZmxhZ3MgYXJlIHNldCB3aGVuIGJyaW5naW5nIHVwIHRoZSBDQU4gZGV2
aWNlLCBlLmcuIGR1ZSB0bw0KPiBDQU4gYnVzIHRyYWZmaWMgYmVmb3JlIGluaXRpYWxpemluZyB0
aGUgZGV2aWNlLCB3aGVuIG1fY2FuX3N0YXJ0IGlzDQo+IGNhbGxlZCBhbmQgaW50ZXJydXB0cyBh
cmUgZW5hYmxlZCwgbV9jYW5faXNyIGlzIGNhbGxlZCBpbW1lZGlhdGVseSwNCj4gd2hpY2ggZGlz
YWJsZXMgYWxsIENBTiBpbnRlcnJ1cHRzIGFuZCBjYWxscyBuYXBpX3NjaGVkdWxlLg0KDQpNeSBh
cG9sb2dpZXMgZm9yIHRoZSBkdXBsaWNhdGUgcG9zdC4gSSBoYWQgdG8gY2hhbmdlIE91dGxvb2sg
ZnJvbSBXaW5kb3dzIHRvIFVURi04IGVuY29kaW5nIGFuZCB0aGVuIEkgd2Fzbid0IHBhdGllbnQg
ZW5vdWdoIHRvIHdhaXQgdG8gc2VlIGlmIHRoYXQgZml4ZWQgbXkgZmFpbHVyZSB0byBwb3N0Lg0K
DQpCZXN0IFJlZ2FyZHMsDQpKYWtlIEhhbWJ5DQo=

