Return-Path: <linux-can+bounces-8207-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AXd8FEG9T2pingIAu9opvQ
	(envelope-from <linux-can+bounces-8207-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:24:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFE732D4F
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:24:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MlHCNP0Y;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8207-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8207-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5177E3111786
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1E363094;
	Thu,  9 Jul 2026 15:17:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364E2DECCB;
	Thu,  9 Jul 2026 15:17:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610233; cv=fail; b=EUNoHEme+m1gmKgu7/eTZmAM3l5SJ0jNAgAyQCCMNTK3rwOFTZgYioNRFJDgxiStOuYdIHWdS4SVe98WIy2cDIgIqJDAq0l1WoG1d0MG6kzjk7taYuqwD958ZaPMpPGyu/EpR1aKYiidhcyI2Y4ftc0n6A9fGU1/Lnltxqberys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610233; c=relaxed/simple;
	bh=3tw2KVNhyKmH3OAGkPkjxU9Z2dWqo8/TPRRdGF0TE/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jdwlBzPmsqqWVa58ASBatgGJHz7NWWuatekQ4dtsIBri8c7qtHqEMNI0IU2h+67WMFPeEyR/Z/wMVECcV7bm2rHK8QfKkFcqaLFgzATMM54cT0sGPLjCpO2Q7u30oopIQyNbS+lyDa7BmO5/nGKrKYbv5Uwf5EACtxF/DSRosO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlHCNP0Y; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783610230; x=1815146230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3tw2KVNhyKmH3OAGkPkjxU9Z2dWqo8/TPRRdGF0TE/w=;
  b=MlHCNP0YvuvrjhZbJBTqsvD5lccExlj1DV4DyiHtkqbi+dz950VEhV3V
   +tmTZ0+/htwxwyHuNZJHCsS9oWvWnwKgB9lHOP1d/fU24Sk2L3666fdEi
   DrBPtSKYxBV/oRvPSTYlQ2mO1p1/iJ+Glyku6OGFvlU+3ZEc/mrf/32ET
   nUhQelZQdejgxLNVmVjS9+w3Le+zg0hDjbD+1RXqh1hZSZvs18V1l3RDm
   NVNJh36+tEV34JahBCqBKjHoBGyAMpqOvLXbK8uA/CkZIsEY1mWCV4rd2
   DX+MlA0zrzOwm8uhGdGt6LrhdOS4s37fstcGvISjvJS23Dhgb7DbVoKqE
   Q==;
X-CSE-ConnectionGUID: HVXD+HWtSNCYy5a/l+yQ3A==
X-CSE-MsgGUID: ZA416RwkR4W1rCEdmqHx7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107092160"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107092160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 08:17:10 -0700
X-CSE-ConnectionGUID: 6zI5ammERbm7vvCHa4npjw==
X-CSE-MsgGUID: QkDb+q1wT/+jJTWDGsIH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253516376"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 08:17:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 08:17:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 08:17:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 08:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD0ecy/hUSM9ojsay9ZzoCeS6pgQykUbeG4GKKPcLGRyFCAhNgWOAfQSw709XTmljekmp2aJMh6fga+oBYMfJCDigaktPQ/oPvXvg+byeQHKodZ2iZMQyF0C50nqOJ74gUU+NMlCQ/LgJbtvlU6HbZZ5t4zTLCNrH/uSn+4njHqdcwgXu4dH34YQdttR0lY4PFzX0CEj+loeWgweF8TFTbhuBDcoLOb72qJiojpF1ydNjBjY9+hpE/1oLoCyeWymcNoEh16GKJXz1TeIC2l2XP2x/dGhkBKhE0LOPU8oRQ8w6eUaXMBi/P3+aWbB27VZOTUtbyT+6zwOQc+JzGdOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tw2KVNhyKmH3OAGkPkjxU9Z2dWqo8/TPRRdGF0TE/w=;
 b=wxvk2rgc8obA055rR5EGBC02eHrFjnWz8bt/x/KnXymG+D4lbkPEPuQlPMPCPxuCHbN+bFhaXZln/BH+yn4RsZjikcbKNlDfJ5pf+nWoBgpNF99mP8tmY5CJwekT9rNJET1FAflR+DgG0DVF0ZmM+pX46s0GOWWx+lu/+FzOKirMexBKq6XlAt4qwbPxF4jiijNu3TP8f+8WUgMy+9/0+u6L/K1L+Oa8NKBuF5r9h2Bu9zfT+eJo9yg93VQQFbBoGlR3+1p0ys5sM86ljIgxU4r8nP+EBqC7sl6P8rSJ6DsHmuJbSzKWzJzFbXLJw8Mqv7AFDYoH5Hijf/Uz0ANK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SJ5PPF2FCF00E1F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 15:17:04 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 15:17:04 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
CC: "frank.jungclaus@esd.eu" <frank.jungclaus@esd.eu>, "socketcan@esd.eu"
	<socketcan@esd.eu>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"mailhol@kernel.org" <mailhol@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] can: esd_usb: kill anchored URBs before freeing
 netdevs
Thread-Topic: [PATCH net] can: esd_usb: kill anchored URBs before freeing
 netdevs
Thread-Index: AQHdD5EDl+AnSuMIMUmH9Pp9JqYiDrZlS6hQ
Date: Thu, 9 Jul 2026 15:17:03 +0000
Message-ID: <PH0PR11MB59027A39F4CACEA80F8E8755F0FE2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260709104620.133765-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260709104620.133765-1-fanwu01@zju.edu.cn>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SJ5PPF2FCF00E1F:EE_
x-ms-office365-filtering-correlation-id: c0bcddcf-5113-4040-4a8b-08deddcd21ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: uuuA9BK7pIrvv082BRPSXyg5nbE61563nBuKGmT0wh0S4SENYG8+0dj8KVzcDhDYPwiBxJlyuL23QxmC4blyd3B7kN2CcdABfiLxa2BG84otHowLo5UD99JZR1j4neeHV5C1W4Bg/+RNIo7cZ2pc0My5FEbWB0qRXR8ZqBG2ZNPAM6ivMwJwxKQYv+m8eafCjScTY7KaIjON8aSubBEbHQZCVcMvX3POBx6bfghYhu5LxrlQJ1ThwFBT5UojvdMMKkUh1YonZvx4EeLrKmWdkLvg+VRPQjnbVKLSCDwJYd3rPdAS9wYaEhd1TcfIkph8raNR8c6fVuAjMwjlFbcQYlWPt35fO94dA0Fp82M+e294u82CcahHkSeKtitwJDueDPnz1E/zKUzHfbVDSL1V5nH27oEcRtMySI006n/K2MW7vhtR08+9Fx8B7DNdkmOltRrBhxrGSpFy1HM9WlTXyGP/2QpPI7hvxGFfga3RI9M47wFEcyFyLXgX67ojAWnFTZgU5PNWl/Sx9ObSyuRzWvWHwStVf/w8JSjt6KCWJNbtVWxgJew8RE4x/vW/2XgRifAIrvZ6PzO2XPV5K4QVjjLxZBUXnL2wplb09KYoWLAuihl/ZXguUfwCEO4MIXpvEoOglZPCa0bJwSiSVBqSF3Q8rK2Cd1hFSUkd65sYF6suEQ73RgMLI9Suf4mKA9Siq6xibTGoAoZT+S5De2A6Q6c3NZvDzGnxRZt8zfcViYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FdiALF87iRNBqXnthXmvqYs7junW/zCaxVtjNx+gN3hb1EVyk1+kSx/wUnwt?=
 =?us-ascii?Q?FYCuWJ1Q6lrNmglb8TSORme1bE46UouyEk/pSZktMXHnyM8GzqZup0a3WY8j?=
 =?us-ascii?Q?/c/f9hcIa6XUlNgnajwnOa3DoJIt2nlmrcAhxmnQUwJn0OnZcwiZslJ8hOeK?=
 =?us-ascii?Q?9Hc5SyVdb+BOh7ofz3rr2oNWvRCtWYcE46wUrCNdzLKFgjwfw9ibsZuvNSuq?=
 =?us-ascii?Q?wXtXN4DnLma08aK7Y2B6KKsTta+BrbPvsNCVeQnv+XmWYsNTGkPpS0Wxpqto?=
 =?us-ascii?Q?Uy+TyZjT8sY3f8CeTv2iEKxjMQ5/+BI/7HfGwiG4OmKbWo6PqTOMQc971+GA?=
 =?us-ascii?Q?gijntY8O8qgKcEEhjicVBW3tEXIiYllJUBmTAuNu4Ah4r2pcOnok/yW+niol?=
 =?us-ascii?Q?KnVAa1Xx+MA9oJbdv1CBMbc6X0PN2n+eO3uz6QcAdH6BInIiRFcjMMAnJxiL?=
 =?us-ascii?Q?jAzVQTtG6j3BIMw6hhZi4NPFLo00r3DES9Hp438oOibcIZ505/vd7CtVr4C0?=
 =?us-ascii?Q?/T/CqaA6p1GbAgeerI1itrBZ5Ruxv9BCW/r7lJq+yrtSHhLMKHkw6UBnymTY?=
 =?us-ascii?Q?ZDsI3waSirZzqwc3uUzi7xPpkYkbCF6lTnQEFtSoL+c4iY5PylBawXsNczq1?=
 =?us-ascii?Q?wFHJBiCJQJlMjqWyFcq0ZV8Td8WQzQS/Qj1x3qKHSNbYA3GIPeo1/kmeykxz?=
 =?us-ascii?Q?3fGA2ICFIpXK1w8i5+lf16iFNFt58qYojmnSVKkLI+PqfctEXnciPT3dTsSU?=
 =?us-ascii?Q?s43wT+e1h5NvqqPQ4zZ+PLCRB2/vODyRzfw2z+rMwLBaJYnb5pe0MCeJgG+c?=
 =?us-ascii?Q?HTXls5ASXlFNyRZjW8cNIvxE1TAJVNVAppdlVojE+7bpqo96dp/D+xP/VKOv?=
 =?us-ascii?Q?yaN9I7PdXWD5+thHPWqLrswumJ2HdKHjZ6dFjmhrQSrg7MnqI4VzDnuqEchT?=
 =?us-ascii?Q?DrmL/GDPPKtQan78jhBHAWvxsra/9l1WT0kYZiRn4Ubt78XskmsFPMR4iR7E?=
 =?us-ascii?Q?97lKBJnoFZRrqqqVj5keyXsEitanS0kG1uLFccnMvzwhNd//r27zyg1PRUiO?=
 =?us-ascii?Q?ZgkEA0jSoPs10jQq6P8wQ0v8jrcEaV8XdoYiknqL5JJCzhxP07HDmxZUqoI5?=
 =?us-ascii?Q?TDO01CaxLR+ZHH29KnAenDAYw4RPpF25W5+gFFg2VrLJdDP6+TUcwA4OVFqK?=
 =?us-ascii?Q?5Lcc060GJO5Mpv4zk1l3Fel9dYh/IZV0BUF0SHe0Pex5KJSaWJGkVaRITg0j?=
 =?us-ascii?Q?2Ni6OHTyjqC6Am5I+eL/rqrL8YrTNNo47oZJAtUNuZr2bNEWSvHrvnJmt5df?=
 =?us-ascii?Q?ZJeTFfPDWdFNzqX9lPc8WX6deeaZS8Y75yDZt2Oy9PUibffaqNXR8sSfdfar?=
 =?us-ascii?Q?K06bl6IlHItMgsK+fhO+/A5RQ0LpiDqKIbo6LxwxExSRGHbZ9JNw+WMOOWaC?=
 =?us-ascii?Q?3w0vgyA7Xy5cx0k9TvugXLPwKMYQlSe5uptvJbOOrSSGOcyMNoUpoN8cRHuz?=
 =?us-ascii?Q?i9GiV1NoUmK1zkqWEBMVq9Yl3y80LhrGEAiCisEb9Qtvpt0rPQGUKq/6Q4LB?=
 =?us-ascii?Q?+g7I8fcssOEnvkL5zTxObVkzaBw15GZ3NqUUnn4/UfvXuMGCs0gnleZcsAH7?=
 =?us-ascii?Q?jRd4coW4ZCrW6QRwCdPWWyq6+PTVrPmxoqiyGF3Uc52liSoYawRtAsbFEkVl?=
 =?us-ascii?Q?BW+DTM/dpKe0EKRztyaPXf07dc6UjyMdfU4J1dZph0uLuiw6jQW9a6cQmJpw?=
 =?us-ascii?Q?6uhguuaBvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V54VmXCueJzNndvoZIIZW+Wmy5y/wqcEHbLE876HrHA6NdxsZah1I4cpGqkc4OxZ2jxAiM9qxnPL8h9oUvDioAScdavbL3SCgNqDVVdpGoqRTfGLib3MexBeToJ4v+IEf0jA+DQJ+hQsTUudg3Njrf7arxwfi6rNIbFoSr6CW24fhpSRWKcgWZ4ocAonYHbKtyHl/U1NVY+eolF12SVLnBpbTJnsgJr5I/Q//oasCUOG/4QRvjwfBwB3gXMRMf0hzNBPBYAQI9JpTlxOhiHgXfQ/9IZx6Ku8cdmfTROsYhpF11AXlRzPTBi5PJoucNtS5TkJr7Brj7EO5p+vacn3LQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bcddcf-5113-4040-4a8b-08deddcd21ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 15:17:03.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzlh4BcpEB3RU0je67ZWUevzc8I+EegECfCgO+l8ffz2vQSBYDPWife7madTwGnbulAr4lfJdhiaZhMeMgf5RJok+bfiIqpndKPQAMEYp+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2FCF00E1F
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8207-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:linux-can@vger.kernel.org,m:frank.jungclaus@esd.eu,m:socketcan@esd.eu,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,linux-can@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zju.edu.cn:email,vger.kernel.org:from_smtp,PH0PR11MB5902.namprd11.prod.outlook.com:mid,intel.com:from_mime,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8DFE732D4F

From: Fan Wu <fanwu01@zju.edu.cn>=20
Sent: Thursday, July 9, 2026 12:46 PM

>esd_usb_disconnect() frees each CAN netdev with free_candev() inside
>its per-netdev loop and only calls unlink_all_urbs(dev) afterwards.
>The per-netdev private data (struct esd_usb_net_priv) is embedded in
>the net_device allocation returned by alloc_candev(), so once
>free_candev() has run, dev->nets[i] points to freed memory.
>unlink_all_urbs() then dereferences the freed dev->nets[i] to kill the
>per-netdev TX anchor (usb_kill_anchored_urbs(&priv->tx_submitted)),
>clear active_tx_jobs, and reset priv->tx_contexts[].
>
>Reorder the teardown so the anchored URBs are killed before the netdevs
>are freed, matching other CAN/USB drivers in the same directory such as
>ems_usb, usb_8dev and mcba_usb, which unregister, then unlink, then
>free: unregister the netdevs first (which stops their TX queues), call
>unlink_all_urbs(dev) once, then free the netdevs.
>
>This issue was found by an in-house static analysis tool.
>
>Fixes: 96d8e90382dc336b5de401164597edfdc2e8d9f1 ("can: Add driver for esd =
CAN-USB/2 device")

Hi Fan,

no need to put whole SHA, 12 first chars is enough




