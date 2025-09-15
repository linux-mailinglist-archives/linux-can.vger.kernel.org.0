Return-Path: <linux-can+bounces-4702-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818AB5789F
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33A920534F
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FF2FE582;
	Mon, 15 Sep 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SEfM7CeT"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2047.outbound.protection.outlook.com [40.107.114.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BA27732;
	Mon, 15 Sep 2025 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936213; cv=fail; b=i5wZRRS24mbSm+cWYX9cxlCVE6/xpWTOZLBrwRZ0OJ4PFwlAH7wqxjifCxJaJeGj6H2JKZI10077so0V3+9I/EuKFwJkDAneXdNSJtctZACcpNXsXXKJxMnvEfKi7YJw2WggP4XG8FzbHxsWQ6PFaigzuhKMR3WMwP1l/y50YvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936213; c=relaxed/simple;
	bh=quv0E5ulP3oBp0M5jA3Igg65RhIKQSHIRAjZ3kxqqzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btTap+/kPYuPihDKZUBjqUS1trI5JxHkUlqaz4nLeibb2/0qOOrJqZm+O2QYAMZWsGPQpy8N7gV1m0TFGcJ8CSZfNxkrsaDfuIyG+lG8tBIIKs5BbKb8BlIjJQnU0a0/3XhdM6jbsqlx6z+Oe8VpT//fdlnSPnVm0wr6aSOggQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SEfM7CeT; arc=fail smtp.client-ip=40.107.114.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQXS9IU8jTkFxxuygzTfk38Bga/yyrWFq7EzeleqdU6NQReONT/2C497yhi/ob2gFv59aLdoIZsmWMZhmgGULq4FU0XWOf2L3/VOoyA53MBAWBj85CeTrwdUj6uRKx9frb1+ZH5Zx3YHUKJlEnUPf42Gzn14FLR3ZNNJlQsUkBn5NM0iV854Ddd/F8UB8ZfmStrfw1IKHAv1BYM3N1wppbCrVmzHpI90Z6SoCPsn++cpdjPR5gVPCpSiYRgncZMeSV+ElH5NgQA7DpBEaP0S+IfJPMcDkNbq5kpbPH0fWaPqr5wVayAv7COPDaK7ZBdT6jNsrE7oPo+wp+Chg7xbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quv0E5ulP3oBp0M5jA3Igg65RhIKQSHIRAjZ3kxqqzE=;
 b=LivWrBhSz0NsCfcz2qObQFUhzQPQdfK/x/DH+OVF413KNEp0ite2YlbpTyJzGTYfY3XDa6DLX54hLKwyMgRiImOXLk3FOXWrYMfE3ZQ/hcyn5JHUWXgrMv+lnrszWaYShyk/nh2fh5XrnvLd/MjlGK5Ni2tRFn7ivBPgyEdI1jHdVHz2SJXTd0qBLE3qynILJrql303S9DYAxONN2kkjhKx51kyUY701GYwagIGUosF4yoUVCgd+gG5g38b8k/mdQEj0BCc7kluVmoGFOA+GtdJ/qG6poSRu5gpElmfBFi3lMqF3k+Xe8koypudQ8GVvKh/m4UAKjfW3gQKoxeiPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quv0E5ulP3oBp0M5jA3Igg65RhIKQSHIRAjZ3kxqqzE=;
 b=SEfM7CeTOO+IZQcK3cCDQfg7EbzcBaK1cSwiRuCcDya7/vmCbK+JPnmvrPgilbevJl+p3lJ3EgsKnRDLOLsfRHCPPa0ULjJKygkSjprsY6ANGF/90hJJFDYly2nh0D9EojHVWQo2CeTVPjzlAhy0CyS8bDNX4ivNGBCY8KyhjUY=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYYPR01MB12291.jpnprd01.prod.outlook.com (2603:1096:405:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 11:36:46 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:36:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from
 probe()
Thread-Topic: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from
 probe()
Thread-Index: AQHcI9KsZZ7chAY1hEWd8DoY6ygXJbSUIKiAgAAAkDA=
Date: Mon, 15 Sep 2025 11:36:45 +0000
Message-ID:
 <TYCPR01MB11332E5715ED698954A87CABD8615A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
 <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYYPR01MB12291:EE_
x-ms-office365-filtering-correlation-id: d23313c9-d6be-4591-0ac3-08ddf44c26a6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?djJUUkord05BemRXZGdOdUc3S29GaGpVMFNZN01DU0h3MnVwM0h0NklOMmV3?=
 =?utf-8?B?QzFNN1U2Q2EvZXJZeGthd0c3NHdrRjZQSGtvMzVyKzNwQjZRMDBVYmc0RzZn?=
 =?utf-8?B?WTlyZ0hBN3ArZm1mdWJWWjJOME5icWhEaWJ5N1BrV09yWk85MTdzbExGWVla?=
 =?utf-8?B?VVZwYVh0QzdRRnY2YXZwNWdKZmxqS3dYblJpWENsSzl6T1lML1NaSncralFy?=
 =?utf-8?B?VUlhdHhQU29MKzhhU2I1L3FhSkE2N3IxYjVVL2lXSE9ZZThmZmpvWEt1Ully?=
 =?utf-8?B?elF2cnMwU2FTN29FWG0wWXd6MnFCVFRHY0FUOU9BeWpyVEJ3UFpnMTk4WlNi?=
 =?utf-8?B?T3lJYUNrMHV0bEpZNWh2ai96bExSRGhKbUtXWGFxYnVSY20rUE1SYmRXV2Yv?=
 =?utf-8?B?Um85WU5zU1Z3UlkwdnlLZ0NnSUhjeGdXbCtXWThmSTROUlJVbHZ1R1FuVFc2?=
 =?utf-8?B?c0ZWRHRpdG4yaVFnaXlGUitKLzBrQ1dmaEZyQXRNMThNV1Z4M2lIYmdNb1RL?=
 =?utf-8?B?YWVva2dLUWtQeldPVDJ4UzBYTUJrazRTalAyWnpyZWE3UHlYMmU4K2Q3eWw3?=
 =?utf-8?B?VEoxemgzTmk2RHUveWZwR3A5Mm0wWFRUeTR0czhnakx5S0liTCtMU2tmTWxL?=
 =?utf-8?B?RGhHdDlKdjFHTDNDdGJNczFMdXdPcXowWlhha0MvelFUNVp2MXdrd2h5cFN5?=
 =?utf-8?B?bjZFQ1l6WHRid3lSejVKRys3NVd4ZmNtSit6alBkUERpbThmZCt2RStzTUs3?=
 =?utf-8?B?bm1IY0ZKcmQ4TFdFNWZBdit3YUdWMUZlU00xaVp2UnlOZzdXdHNOV2ZQQVJB?=
 =?utf-8?B?UWxHVEpnUGVrMjR6QzBkVzNYZVpjdXBTMWZtSGZvb3BGaHFOK2F2UWQzR1hv?=
 =?utf-8?B?b0hvTEw2c1Ixaklhb05iUTJodmpvVStMMUFtNU9KWTJRZWxXZVdFanF0T24v?=
 =?utf-8?B?Y3FPYW9iei94ZFV4YWEvc1dGem5qZVZ1dW9hbW9zOVFCVm9tN0haQmRiMGpj?=
 =?utf-8?B?N1RUR0QxZGcvd3N4VTl2R3BjNVEyWnN3bGk1Y01OUzZwNS9WR0FqM1VyOFF5?=
 =?utf-8?B?dHY3bjBMTmZjRTJWMlFKVWZRSUJ3TlNpRWZqbk1IaHJsb3dpVStPZC8xMG56?=
 =?utf-8?B?YTRUZ0l1K2UvYnE5eFpOcSt0cEYvVGxYUjZGVTk1Wkc2cmpIbkZtbFZ3Mm1s?=
 =?utf-8?B?a0MwbFJqaUI4ZVRUUnRUaElrRWd1UGtOL1JCZ1dLcjVWZGJoOXl3eFR6SWdN?=
 =?utf-8?B?cmdvTmxGRzBTaFVHVEIvZHRJWS9jUUpUYWV5ZCtSYjBTTktJL1pBR3g2d3dT?=
 =?utf-8?B?RWt0bTZKY1BjakluS3ZteGk2d3Zza2FEcWlzanZTR0JBamZpdXBvRlNTbk41?=
 =?utf-8?B?alQrbGowb21hMEVUd1RUZmRYeXdaTUE5WGhTZmxmRktYRWlxYlEyeGZ4OUwv?=
 =?utf-8?B?OGQ2TEZ2RWt4OWtXVmdvZ0R1SzRQTGJiTFVzN1I4RlAwc0lveC9oSEF3NE5i?=
 =?utf-8?B?NDExOHFBSUZWYXZRRWNuUlIzc0x0RlFQeXo2eW1TVFJlWjVKQ1FLd21EVW9W?=
 =?utf-8?B?YVlKYUJyaWordGxqNmtXN3oyMExEaVhyQ0s1TFF3WGJlVnNtNjBUbnFMMlFq?=
 =?utf-8?B?VWRpd3pieG1IZnNCcUs1SUNzcWM4M3NmZElodysxK1FxQmhnNnY1d1I0QS8z?=
 =?utf-8?B?bWhEWmplQ0ludnlvdklmMEYzN01jYkZOdFJSYTkxYm15SHgvd1J4c1VXd0hR?=
 =?utf-8?B?K2pMNjFFa2JyaXhBY0tJV2hMNjk1bElXZ0tIMUFGVDdmdDhKc3N6cGpnalV1?=
 =?utf-8?B?MmgxVG9LMWdwQk1tcHpFaTFZM0g5c09LOVVmS1VxaENkSkFiZlg1WGQxRjRo?=
 =?utf-8?B?SlBLVmRkN3ViY1JzbC9XWWFpaGJubWt5ZWZtNHZhMXRIZEVXQXZJalN2VnNB?=
 =?utf-8?B?b0QyTExPajdZaDhsc1lxY3hwb1pBRnIwcEdFcW5wZGRybi9sK3hFUlI1bTBF?=
 =?utf-8?Q?dobxd8joZBEFZ3MQ8KTx5bamkbThEk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGw0VGZPK2JhS3p6NmJpOVlrazV3U3F0UWNob3ZzZ3hVMGdjRUduK3pVSjY5?=
 =?utf-8?B?U1pvRmdkWFIzdGY0dStFcmZmSWJIL3NjNWViT01BV2E4bXdXQ1ZvY3AwVGN5?=
 =?utf-8?B?NEc4SDJtaml0TVR0bzhkTWFVVDBTN0JRWkRRYmJkV2ZZbUVZTzRWdUpiUlZC?=
 =?utf-8?B?alNJUEJTbWdva3llSVQxSVo0b1hOQ0VreWxyS0dRYTdKK2VxSWYwSVJTQ2NF?=
 =?utf-8?B?Rm11SVo5V0JMTTcxWm9IT1FpVkJldlljek5qaEhVTFdQZW1FNFhVZWFQSHF3?=
 =?utf-8?B?RzJIZE4wblo0Q3RqSlp4NGwvcmRxSzQvblduT1JQdVFQUXkyMjc4R3haTmhQ?=
 =?utf-8?B?MzlkY0FtR3N3OXhGeU96bDk2NmJMZzhxcnQ4RWJ4SUNmVmZrenBzVEU5eXVi?=
 =?utf-8?B?S0NjUlczU0tTMDgzTUhoajNJQ3BkTklWV2IvSDFDcHo1ZFNNcmRuVWNaQ1U2?=
 =?utf-8?B?V2dmTitzMGJUVGxGZ2pJUGxIejhPV1o1dXg5a25YZGNwTGFJUXZPd0JQZlBO?=
 =?utf-8?B?d2hMS3cyVWkwS3N3aW1aMVVzVW02bW5TOWRxSkMxNS9zd2JFaVA2Zk5ROXRi?=
 =?utf-8?B?Q2VZeHpuL0hQRDhqRXBEYzZKdFl1ZnJ6TWwrdmhsWWJwZ3lzV1pGanFSV2RQ?=
 =?utf-8?B?cjFxcWlFNWI2UE43TmJWOVF3eVlMcFo1aVFia0w0ZVhmaytRTXZtZEs0bGRl?=
 =?utf-8?B?SzNVbzJzYnlRNG5PMVVMRDNKQ3JRd1QwUThueWU3Z21aNHIzQWxSVVpJRzhs?=
 =?utf-8?B?SkxySkRvaUR6S3NweUVTQURzQys3WldrV2V6NGVXbGdBRXhzTTR6YllXcis2?=
 =?utf-8?B?dXA1SlpFL2t1MnM2QkNqbWRvV1BBaU1IMzl4bzRlZnIrbUxySHVjS3RER05t?=
 =?utf-8?B?ejFlakorV1NBc1lrT1FaUGt0eG5RUzYzcVBPT3JGRFBaK09aZWVKSnBCTzJN?=
 =?utf-8?B?NTIrMkZCL0kvUEk1Zk5wam9JTUYwSG9MRnpZRmFIUVdkTFFHS1FEWjlZNzVL?=
 =?utf-8?B?UHduUzNhRkwvVy80eFZsOHNXMjg5S2piaCt2c3JMZkovWmpnc3JDNktyK2RP?=
 =?utf-8?B?Tlo3TytSUFFkY1oyajFMMFE2eFE5SEdjbTZIT1VJS28ycElYdUtpdVIyL1I4?=
 =?utf-8?B?Vk1oQm55UXhCTHc0WE1oZ2tpVmRzN29oaVY5ZVdQT1RQQ3VrcnJlV1BVMjV5?=
 =?utf-8?B?bXBJZnljOEhibHZYVHFpaUtLeVdUYzhFOXZiMUh2SVh3dXlyeU9jYWlOTEF2?=
 =?utf-8?B?MHgvQVBLNjhuWHJ2UjFlNEdxSHJhQ04xZW55NnhyeWN4aHY3d0xmT29CVU83?=
 =?utf-8?B?WTZmKzhuWlJSbFBIMEcvbVN4c0NESkFzcmRLMmM1Z3lpREVGVVhmSGJtRGow?=
 =?utf-8?B?R0gyN1NZR2NTcVNoNGxHRk8zS1lKMUdpdkprVU0yeUoyYVVrdWpNOFU2b05v?=
 =?utf-8?B?Y0E2VEs3bmJISm1aTmtkOERYNklzb3dLT2o3WTB6TUJqa3lnN0xpR1pNNnNY?=
 =?utf-8?B?QlI1bG85ZGhKS1ZUMmdMVTdHWGRhN01naGt0eWxyUVVaZXkrRXNJbjhlaGVt?=
 =?utf-8?B?MWNRWm15VkJiUFlTRVVoNTdrRnZWMSs0cHBkeFBZWHhmWkhPdzQrS3FtVHpk?=
 =?utf-8?B?eHBWRjBpTTVacDhEaVo5blhBM1BSQjJlSHFqc1cxY2VBVjkzTldHdyszVXBL?=
 =?utf-8?B?RTRwWWxISlNTa0JSVjVocjRNUWRoZVovaGVMU0pwYi96aTRuWnlBekxOaVdH?=
 =?utf-8?B?cUd0ZStlb2l5ZUg5SDdBSG1MRU1BWUNwSWx3dEY1eWR1ejJITE9sclRqZll2?=
 =?utf-8?B?QnFhSzB0bndUaTZHbkJ4b1lWWnNmUk5WZVQzdDl5Mk9qbzFHZWs0U2VpQjRJ?=
 =?utf-8?B?TlJjSVNZYVcrWVFNN0M3Ry9ra1dIbFQ5eGtMYlpvNytCd0NiblFVNmhDUys4?=
 =?utf-8?B?alluMGtGSkgxekRveWFYS1cyMWNPY2RJa3l0eVBlR095NU5lMnBkMnM3QnM2?=
 =?utf-8?B?b0lieUJZY3RvdjhJVXRCTENGa2dodGp6TzNUTnh4M25IbW9FbFQ4YXpBNW1B?=
 =?utf-8?B?VmZac0hJMGtBMU9uMldoK2VobUQ5U1B0cHBCRCsyU1k2REhsZ3VJc3F4ZVh3?=
 =?utf-8?B?RGtqdXNTSmVDYUNod1FjZ1JwaklEczdJSE50dTFXUnRwcENqdFVMRDdXRExq?=
 =?utf-8?B?bEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23313c9-d6be-4591-0ac3-08ddf44c26a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 11:36:45.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwKC7x5s9R/z+FcHwapplg32zMJ7Jy/+lacHFFrQJRJ3lqJK58kknETTEtfIu99Hm8VOtQS2muc2n73rzIBrEujvJ/E+LsVB+EImyL/PnZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12291

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE1IFNlcHRlbWJlciAyMDI1IDEyOjMxDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMy83XSBjYW46IHJjYXJfY2FuZmQ6IE1vdmUgZW5hYmxpbmcgb2YgUkFNIGNsayBm
cm9tIHByb2JlKCkNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
DQo+IA0KPiBPbiBGcmksIDEyIFNlcHQgMjAyNSBhdCAxMjo0NywgQmlqdSA8YmlqdS5kYXMuYXVA
Z21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4NCj4gPiBUaGUgUkFNIGNsayBuZWVkcyB0byBiZSBlbmFibGVkIGluIHJl
c3VtZSBmb3IgcHJvcGVyIG9wZXJhdGlvbiBpbiBTVFINCj4gPiBtb2RlIGZvciBSWi9HM0UgU29D
LiBUaGlzIGNoYW5nZSBhbHNvIHJlc3VsdCBpbiBsZXNzIHBvd2VyIGNvbnN1bXB0aW9uLg0KPiAN
Cj4gcmVzdWx0cw0KPiANCj4gTm90ZSB0aGF0IGFmdGVyIHRoaXMgcGF0Y2gsIHRoZSBhbW91bnQg
b2YgcG93ZXIgY29uc3VtcHRpb24gaXMgdW5jaGFuZ2VkLCAgYXMgdGhlIFJBTSBjbG9jayBpcyBz
dGlsbA0KPiBlbmFibGVkIGR1cmluZyBwcm9iZSwgYW5kIGRpc2FibGVkIGR1cmluZyByZW1vdmUu
DQoNCk9vcHMsIHllcyB5b3UgYXJlIGNvcnJlY3QuDQoNCj4gDQo+IEkgc3VzcGVjdCB0aGF0IG9u
IFJaL0czRSB0aGUgUkFNIGNsb2NrIHdhcyBkaXNhYmxlZCBhZnRlciByZXN1bWU/DQoNCkNBTkZE
IHdvbid0IHdvcmsgaWYgdGhpcyBjbG9jayBpcyBkaXNhYmxlZCBkdXJpbmcgcmVzdW1lKCkuDQoN
Ck9LLCBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSByZW1vdmluZyB0aGUgd3Jvbmcg
d29yZGluZy4NCg0KQ2hlZXJzLA0KQmlqdQ0K

