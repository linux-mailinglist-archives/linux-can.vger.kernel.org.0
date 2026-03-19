Return-Path: <linux-can+bounces-7158-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNQlEnoSvGnbrwIAu9opvQ
	(envelope-from <linux-can+bounces-7158-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:12:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCBC2CD7D8
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D243065F0B
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB43D5221;
	Thu, 19 Mar 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="wpmxP24b";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="LjNG9pwg"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com [205.220.173.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A93E1D1A;
	Thu, 19 Mar 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.173.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933046; cv=fail; b=lkF7EAX3jW3vV6OmmNpx8dyrAlvXjcKJUB4WTBxRdyfS022Zmg6SEfJkjq9RZp38jNRkBbrv0NlvwRXbRYTPeBmAkB1K4QWRKpth6rkkWRdWHH/04DbpMVyGOtfG5j7uyOTLPsdf9GvK8ISl9hEfts/V40pKlMBxdbsIEPaE1Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933046; c=relaxed/simple;
	bh=qgXxDyU7Vbe3sAYSdy5x1YcWT87DTxhiEgLz0xrrMSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NH89P/UjF5H7pbYzY4SnGz40e6kDS/tPVDjQCvM/gkId7DygqRyMOGisoF8/xgK8441gP14a+/kiCN1mY4ZJ8rlZJaU1ZlIJzMof9CVQ0SJhQaY21Oz9AXe3LnyPpVtXsrRjJq120UHAkIyiFdCJo0RsQoc12kYL8huVqC48gfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=wpmxP24b; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=LjNG9pwg; arc=fail smtp.client-ip=205.220.173.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187218.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEJ9Et1601845;
	Thu, 19 Mar 2026 08:10:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
	qgXxDyU7Vbe3sAYSdy5x1YcWT87DTxhiEgLz0xrrMSc=; b=wpmxP24bKO1Uc/1V
	+xhqLIyiz1OoJvsnx4Mr6TW5n5yVApmknCvwtDAVfQHMHXNGvnhXNM+jefRVs0S5
	0ixLo+s41z3l4jJxM2lfwQQIk72NZMDUL+Xhc7HukLXUwWbRztpDCOyrNOIAswIo
	vwCTgur5dBjs8yrQLHY10xa4Ji6Vh80Bs/e7izqO9WsHq7oHU7abu+UT25KeXcy5
	Ejq7+BEZqyyz1sAMo7eG/ozDd6WKdRMyML+1i8ZIr+r5SEZbLfHHDXqZsHb3DxKd
	gBhTkVqm+LXiKzCuIuidpNZSae6Mt1lQCA/5PQKewlAWydyV6uNA0LqfkzNChDB3
	IWau+Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 4cy98m6sgm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdMy6E7YMKwsKtmA7PaK4Ov0TQ9oxGGmmamyWG5qfVqio6PyVT5t3t7v1evRhC45LTVlo9fR1Rpz37Ff4JgwXvjzAFl8mRjkuW0oQWqhL/J34I8f2NDXmqAMQBKSlVsh5lxcWhxLP2Q+MKGYuOgITtO9nll/M3tgBS/Lq10iQQcHXO1/bRx/VtOgbr8ilsOO2IexWvmDt8dLuEBNe3gL7eGNSVKwe1oV9vcNXPtSAy3sH1j1such0sxqhX9+ekx40xSqN59nRFHq+6ll0LRun7EEcC4Hb/8lgdiRRUE5mt+eAFSVIxCYELSs3rJ2/s7chxKNKOBFYHxaO7bfCifS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgXxDyU7Vbe3sAYSdy5x1YcWT87DTxhiEgLz0xrrMSc=;
 b=xkdvb3tKxVfjSPOURcMuRkBpK6ulLtwu9tL9yBX3mkARhew2wdPCOKIlv+9Z6JAKyFFitOEy45yYGNNHGDIqFKCZhgQ2GSpSwUmvs4kr4nd7YABTAXwzVZL0Pb2edUyuEs5fSq1oBGCFhrjM0MWblWVASt8Xzr9iZuv1iV76h2GT53NolDMzrO1RrIFlq1NrkfoecvPy1fHJg/45CSvLI6U3gAaRigPOrXsW5U4N+fSzk7z+HMSDb1Gxtepb6aLkgIHli/iDehc6Haaae9BEMjhx5CPd2FdOZni3a2JjXWDwzfr1Pe6cLWM2ho6DTMx8tTpLiSSYouiyMqbqaUQmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgXxDyU7Vbe3sAYSdy5x1YcWT87DTxhiEgLz0xrrMSc=;
 b=LjNG9pwgqRUUsZmUnQRqoyjBwemnuHpUDIycl653boq+vrRkvp6re9Em3Jljlz4/AOa8iZTixKW/jdjTT2Uf8H8EqSP/+YjMJEhsOHDDwhBSJEi2GasHfMmyczHn0vK3fTSLFTB2YufoRIq4h3560K0L9DJkNPr/PRwqOB/YtQI=
Received: from DM6PR17MB2874.namprd17.prod.outlook.com (2603:10b6:5:121::21)
 by DS0PR17MB6943.namprd17.prod.outlook.com (2603:10b6:8:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:10:34 +0000
Received: from DM6PR17MB2874.namprd17.prod.outlook.com
 ([fe80::c4d8:43a4:baf8:7f9e]) by DM6PR17MB2874.namprd17.prod.outlook.com
 ([fe80::c4d8:43a4:baf8:7f9e%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:10:34 +0000
From: Ali Norouzi <ali.norouzi@keysight.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp
	<socketcan@hartkopp.net>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Thread-Topic: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Thread-Index: AQHctveAUiHjlG3cREmJRvwCGZvambW18+WAgAADEuE=
Date: Thu, 19 Mar 2026 15:10:34 +0000
Message-ID:
 <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
In-Reply-To: <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
Accept-Language: en-DE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR17MB2874:EE_|DS0PR17MB6943:EE_
x-ms-office365-filtering-correlation-id: d507fb2c-bf5a-4680-5ad7-08de85c9ab66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 e13r4xXLbpU8m6rGSsrbzbaQoYa6SmZbx78j5prFhTQtrA8aLT9MwwKN/MAxC8SDqHjrK20HPsDworjs5AQxgna/zGUIfYXSoch3Q77VPl/HhxRH3PA7iPuPQxVtdnnR0VhjqfnV9xhT8fEKIxQV0P9ZKwmFtkjvVu8yXqcjtPtevGl/Xw0l8WLID1Voqzr1ciQJOcKhYdSADOXERJ7SQ/26+VI487mqJNKzC4nwvzOBhZwErqBv2zaEdpfneSbXuBF+e2JhO3P2Du6lfc0hGPV3pnHvfSNBKzwfhkhzFZu2yT7n6eHHkmtoZ3nX+mxqyIepnFgxxxE9vhdub/aIZ1Po+BLH9dSvz0kLChil3nAcy424uJyg8u7ZgU7j96rtojsgSxTUtwkD3Am7wRe7wq8xNkgxr4hHXp9vK5ao5usKsC9hEuQgiCmr2lAZLfwxSfmRlJ8PTDakQ8TDo7Os2RLeLMp5xx+kWtsnpXR4fhz+Iyc1Aygkrw8Xj9+poPuPTBel0PLyibBaTTtNZZZxywDT/wJMoccrENqTH/zagquBHUNil/ww1HQ45Zny5H0ocaI6xLdYp4NU8o1SM1etHbBx3aeTUCtWKyxPX/Pyc6zYwO3eMVQM8KkznnBkGIqesF889maQzORUu/yLq1nUxuKZp5a+CH1EfnA0y7FoWCLXe9jA3Yw7ezPQwNXt/ol1R1Dv/PXfadQf9vHJKbFaJJLBJUwLUiQc85zeHljynBE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB2874.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+iP9eCpT/0vJESQL8XA+CIjQyXqrVY8muRKx5y6Lv7GIFI4QBDTarNkNYh?=
 =?iso-8859-1?Q?kkq/9jsjCWZ9ube2cWwpDI9PD6iM3QhDqwBGNckmazoYSHfoqw/9hBXs9f?=
 =?iso-8859-1?Q?6sOahAPn2kx0qXfIM4ansRZxhGXGkcGfew23j1nUJSGurYBBAiuMZHQBml?=
 =?iso-8859-1?Q?71PbiaGixiNPbQ7jXuVIDPpuGh4eXoy2fLsY8+oFBwU80DXyQ17eE8D+Yb?=
 =?iso-8859-1?Q?XPM84XtG7ESUIUyoaGkQ4/DVMOtpZkQ2QzGkXBhUaiOQXskW/8TYnvzzjZ?=
 =?iso-8859-1?Q?dW6OYJKkBP+IYuw7Qj4XP3JdtjFYb059Qw/L7JHazeB+eS/Ictijjh49id?=
 =?iso-8859-1?Q?m26LaI1p4U4fjuQRYhmlcrsgkIZJvSRyY/DXliVkOGEDdiZ5GlGHRJnUg1?=
 =?iso-8859-1?Q?RkF9Qf97K6VlhT5KXIheq6rVD+eGnPNHkZ4Ow2m5iMnIR/XTswJfLio79X?=
 =?iso-8859-1?Q?UvWCJbDFWUp+1EbTfWMqSdiamu7Sfz9HTvJf1PGO9VcE545kP2CqfReGux?=
 =?iso-8859-1?Q?uZSrWL0PIIqjSE1bUO/PP/g8YQ8BjEozv/atomzCArOYFekWi8/1YsTcdx?=
 =?iso-8859-1?Q?lCOWlaZAdmPHLPceWDtYUVKgQ7Ul+2ZiCcpB3LLx+br7zZtgtwOfijkTf7?=
 =?iso-8859-1?Q?JOI1vtwMWxgWLC09o4SN8dtp7DYyaqJyBo1TJBxhaLi7okcMOzo4pC/QG0?=
 =?iso-8859-1?Q?TVYJvDgKKAYovbeFDBeaFcv6gU+lUcikqbYv2zOfrG+1eOF63AMxPJRuZ1?=
 =?iso-8859-1?Q?adLwxFmWupfo0+KlTWQD8Z8di59ZG8IDPFCHUyI9igWV6+8rS1A19G4JWr?=
 =?iso-8859-1?Q?nvVMLxZ8+GBYHHzZGZ5MHIzfYv/abr6oUnYTLrWFWZTt2j0bpKDsZNWdYG?=
 =?iso-8859-1?Q?JwtJYpf5EJHaW7JFW7VuUwdeELi7Azlyq+wyPKRZSXkvR34/U3a//CRJ/G?=
 =?iso-8859-1?Q?6pC7LNRXMCCf6T5+rrjSVtZtFOwGGlAd7MB+aHuQpGhEPHXS5WT8lCLLYg?=
 =?iso-8859-1?Q?TKFoshRgKLqidbTrkuBLorCy2MR/Hf9sUbNRzr9qE1mKTH3UX9FMYHhOgO?=
 =?iso-8859-1?Q?62m0yPx+dq/hWd9cUhtv0bu32CQ0UmpNvdUE7SS9ebMdBxafud16SYNRQL?=
 =?iso-8859-1?Q?5Lb/xNYD+oTsObDVC84LLtHN3fBG4WgZZheo+LXv9myOyurHNdZ8qhsg0H?=
 =?iso-8859-1?Q?R1Fgd8cIMbN7qSK+lQe/VGICN3IRX0ODgxtu1x8OvyvCWDV9K+JxCUKceC?=
 =?iso-8859-1?Q?u+k8crGQh8m/hzdxd8fEuOINTBvB9vPN2izPQVYzAK9VdlnewfJ/bcWIa6?=
 =?iso-8859-1?Q?Kc3iH3cwgyaytI5QZTxDGpin1VgBq4VNUdBthI1Jn2qojrHJXBCGZNuNCQ?=
 =?iso-8859-1?Q?CVpHrdf0YtostqTHsxDPe4BqW1GQdwAksPFMOivCXlIewyx951ejxMjC8p?=
 =?iso-8859-1?Q?MLin2DvLx2dTgRyNMN7sz7Fk+mbYuqz4E1VV8bYC0GyWMU+dDgmBygO188?=
 =?iso-8859-1?Q?KNHJGwx4wO+tEMsPSzxKBc5gswKR/bjpRPD+Jpg4Pn4Iy6JrEY7oO1b8oi?=
 =?iso-8859-1?Q?T6pyCRqzQXVVVHa1FUgY31CXDdpPOoOQGSNJN3pQHavdobyxyZYw8CLzqC?=
 =?iso-8859-1?Q?RhAyHuWbB7VcKK7wil0hWVvDiGE0wOfLU1oWrAsy7Iy4EyjL/mFVheDcbl?=
 =?iso-8859-1?Q?uOl/w7WUKmTh9tmLHCk8hG+5jhfe1gNIOSg6gGFPijfNfQLLt1MCyT+IEg?=
 =?iso-8859-1?Q?DjA4YlHdFbpeWiJob2v/7Mwk68gopeRpIWreiS3Mwm0oujKsL8HaKLIxhe?=
 =?iso-8859-1?Q?U65V+krQSNcHepA8D8IhZwd8cVkZKeEHPkWU6B4eA0KsayXaV84BErlOfS?=
 =?iso-8859-1?Q?99?=
x-ms-exchange-antispam-messagedata-1: CwXFJZjFDldX3Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RW6TVB5lMdBzGfSLEesEqH6ADJiE8Qr54Y/wLOt7dOzTKkVncjsbuvAosPw95voxhEUZzKBEyEbU8eBpxOP6ZGSvOStf4bVRrUgEGjhvuz396DeD+uNJTDBJdI2p0TLOAG2XG9sKYkmfOBBx/gcQcp5StIVRi3mFsDDk2kMD1hdKhrHwUyHQVRxsz7OgNsSZPk03qSqLd1gxQvVhJzDpfm595iNkeaa/xsYO8qOjM4mlpKDw/mOkuPShluSTlxQt/m1OYXN43DqpD97ESHnh5fMSwRl/EXoq0iNI9zlJ+JUi+x/QGuKRJZWNDqZDksnzEXd6R6ifBqYzCSVRj7W5UQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YCK0Gll+L/v2wzJWDv26OMZWk4GagBnmv/Dq3G0pUBitjXvnPL8YoliBKAHCfNBIKH/u2A2s5hZ8P4H3SKj6xlgXL5kwDzLpzYH6HNwYYhr3AjpmWn9qUSmy/0PMBo2oN9oUuk32IX9DP19g3xllunonBiXXi0vHbo0rk0bFw+pOmudp/DOd8xfwO7IuIqhndDkFM+TTlizmZWJCh6ftjYXvEPNcMPGmc7G91r/InaPd4fD0zocEse92CICE+Wo3/bUOFjjn2iN8QkZFxBixseknSgzKWFcFkOKNhv/ldCdu5LVE0GFQ1YxFAx2RE0zKexykWzVWajJ6250lhXPNdq/Bdgrfqv8sUBEuBEfsanTJpfUo2BJWNFYsO1LTsh3z1MrDPkxIicZKYDt2hvYTiObIXuPyZbIAadFNt+Pz5O4XatCZ+R3JfKXIu/+mjjYqxBfNeDV9CNCjsrgIWBq1jSyERXgnztvhKb/L75s0lDDkav06/CS03HqTk1KCrSauaTNAz1RpJZUcJ8UTVZz/xPX83eavH5IxFgj44n0psJB6CJZAzTyT9MySnIrR63vchFNPliwaEpoOytejlEFLQkj9/8UHa+3WhdmaYZyH0PY9khUTyfeEhim6bKeeLKhD
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR17MB2874.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d507fb2c-bf5a-4680-5ad7-08de85c9ab66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 15:10:34.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrLRq/A0Kps1cnuBlC9wA3zChPVdjUoZrdUooeDJ/rAqKHyUsz1xvLJpVKNG0f0YUon2q83S0Pf4hRjqMju41rHbQb6OkViHR98huLaJeMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6943
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfX9giAL5O5GvO5
 mET/FlZVscGVUoO1GZyujpRXZ++FL5sZqaiCydBmOOiMlBzpWyBIvb/6Hveg9xCWFrDgNdMvLjL
 /G6DMWGgXcFDBqtcuIN0tpUwTd4MhuHQlEQTlWxhaZ9JU9bPHTrqfN/zimCrTOwYNtak5Af+TKG
 8iUJ3V8smEZ9ZLFoT4adxddJZJV1d+NpS6CgMhKN0UpcuRxkSGiXkxXEf4ZLjpgh3td/KvzbFfd
 2bT81j0YckloGCtIFwV4vr0tBkduBV/+a8VOCJJNk9gy7Lv1bL/XCAlMYv2ERQ5rR5AKS1yeqqR
 I+6wVOTZjv7q3teU1DARt6JhIN5OEpBikl2qqF+tWO9zB+TosuyRdAoe2wLbB5yDy2fG5hJdB2s
 23p6H+/iKx94sU5FR6O7j7bHP+nWw+VfvDYUGkGEZKrf+B2I9zNPlAdJywB2jsedk0bdKe44fl2
 gp8SrPZM234P6oGciPA==
X-Proofpoint-GUID: pwh1cYLF6sETxPAR9cTy1Dt3Knh4Jrnz
X-Authority-Analysis: v=2.4 cv=CdAFJbrl c=1 sm=1 tr=0 ts=69bc11ee cx=c_pps
 a=55pr0gqEmxT9FJl44qZDsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=vu2TTH8h0NUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FLoIbiw2ZNY34kqd41oa:22 a=hWGxauOIDdI-otBKxhKL:22 a=bGNZPXyTAAAA:8
 a=VwQbUJbxAAAA:8 a=F6MVbVVLAAAA:8 a=pGLkceISAAAA:8 a=oZC0XEVVAAAA:8
 a=bDMX3XBENpfRKTw38y0A:9 a=PRpDppDLrCsA:10 a=O9Trw71uoXUA:10
 a=wPNLvfGTeEIA:10 a=yL4RfsBhuEsimFDS2qtJ:22 a=6mxfPxaA-CAxv1z-Kq-J:22
 a=zp9zYjvQfU8auYymo08R:22
X-Proofpoint-ORIG-GUID: pwh1cYLF6sETxPAR9cTy1Dt3Knh4Jrnz
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11734
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190120
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[keysight.com:s=ppfeb2020,keysight.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7158-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DM6PR17MB2874.namprd17.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[keysight.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ali.norouzi@keysight.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[keysight.com : query timed out];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CCBC2CD7D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marc,=0A=
=0A=
Sure=0A=
=0A=
Best,=0A=
Ali=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Marc Kleine-Budde=0A=
Sent:=A0Thursday, March 19, 2026 15:58=0A=
To:=A0Oliver Hartkopp=0A=
Cc:=A0linux-can@vger.kernel.org; stable@vger.kernel.org; Ali Norouzi=0A=
Subject:=A0Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in isotp_s=
endmsg()=0A=
=0A=
=0A=
On 18.03.2026 17:51:20, Oliver Hartkopp wrote:=0A=
=0A=
> isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access=
=0A=
=0A=
> to so->tx.buf. isotp_release() waits for ISOTP_IDLE via=0A=
=0A=
> wait_event_interruptible() and then calls kfree(so->tx.buf).=0A=
=0A=
>=0A=
=0A=
> If a signal interrupts the wait_event_interruptible() inside close()=0A=
=0A=
> while tx.state is ISOTP_SENDING, the loop exits early and release=0A=
=0A=
> proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)=0A=
=0A=
> while sendmsg may still be reading so->tx.buf for the final CAN frame=0A=
=0A=
> in isotp_fill_dataframe().=0A=
=0A=
>=0A=
=0A=
> The so->tx.buf can be allocated once when the standard tx.buf length need=
s=0A=
=0A=
> to be extended. Move the kfree() of this potentially extended tx.buf to=
=0A=
=0A=
> sk_destruct time when either isotp_sendmsg() and isotp_release() are done=
.=0A=
=0A=
>=0A=
=0A=
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")=0A=
=0A=
> Cc: stable@vger.kernel.org=0A=
=0A=
> Reported-by: Ali Norouzi <ali.norouzi@keysight.com>=0A=
=0A=
> Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>=0A=
=0A=
=0A=
=0A=
I'm missing Ali Norouzi's S-o-b. It was in the Mail that Linus Torvalds=0A=
=0A=
forwarded us:=0A=
=0A=
=0A=
=0A=
mid:CAHk-=3DwheQ2o0B_-EV5H3w=3DZZS2huESOxrvTaub_EbrbAMbgi4A@mail.gmail.com=
=0A=
=0A=
=0A=
=0A=
Ali can I add you S-o-b here?=0A=
=0A=
=0A=
=0A=
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>=0A=
=0A=
=0A=
=0A=
regards,=0A=
=0A=
Marc=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
Pengutronix e.K.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Marc Kle=
ine-Budde=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
=0A=
Embedded Linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | http=
s://www.pengutronix.de=A0|=0A=
=0A=
Vertretung N=FCrnberg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Phone: +49-5=
121-206917-129 |=0A=
=0A=
Amtsgericht Hildesheim, HRA 2686 | Fax:=A0=A0 +49-5121-206917-9=A0=A0 |=0A=
=0A=

