Return-Path: <linux-can+bounces-2654-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF6A1246F
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 14:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089DC1888D0B
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963B241692;
	Wed, 15 Jan 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzH9g0OP"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE291863E;
	Wed, 15 Jan 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946545; cv=fail; b=AjYLt5UWMYejjJ/6GW9SUutvQaw6v332r92QNPDgQEY6pn0Vt9cHyIVDtOJwJQsDVZfH8FG7s5xS3GSZuAarXX6KKttCFJF/75DzY0uYn5NIJ/4Ag7jA01cTSkRKUBRkg4yfhk9ktwxSKwpvIbR8Lx9cVfAoRUvpmtZdfPA1/Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946545; c=relaxed/simple;
	bh=AfnE7EH3+oZ03y/HjcU2sK1220pd9JI5H3fxM53Mo2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8t9M/Xgaj3IClG4h16xqKLZPZw2TKZ7YT3Z7+RQPnoYgxaby7PRUoR2IXSnmcJAISqsAYgMReMD7QVqECSboL3dxqhbclgkRlKw1jaYSK49KaPOJfpg+FTv5ANictqBhNut+z/37PtEMI+csISJNF5GEFPmemyysleeRZT8cqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzH9g0OP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736946543; x=1768482543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AfnE7EH3+oZ03y/HjcU2sK1220pd9JI5H3fxM53Mo2c=;
  b=VzH9g0OP9t21UEWYFuwBiQpMMr5a3xmA0+0Pda4kK/oD7LGF136DX0oY
   mwdB1a17+TNbUPrEPB8kZztFezA6ivpGzyR06T8HVUrpjEgiCKQJAjm17
   I6/fqjOAr55c02fFXmD0ccK4tFL9ly3WuNx5p7KwS4bXBul3olXnG0yKm
   yU1ZEZL9sPbHGoclMGii8M3fAlY95Fb3a03voePLJU9+uh9LoG7EyIgr9
   5OFSr03P73xHhjUXg63anYLN2EzG+8SuzPCaSzL2l6HU7xSiSUQsPmhHf
   8Gb03X8b3VMeiq5PurbyyLtTcBxGWaSZTVoXrra3hsJ0kZvSUR/vSvB/v
   Q==;
X-CSE-ConnectionGUID: O4uNUrj+TFKf7q8PrmtkcA==
X-CSE-MsgGUID: 0VeyZ4VjTb+cgbyAVDY/ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37198169"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37198169"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 05:09:01 -0800
X-CSE-ConnectionGUID: kE3br5dBTRG7JZDLtPdVvg==
X-CSE-MsgGUID: 37vU3ojAQPa5HeXmwehkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="104968597"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 05:04:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 05:04:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 05:04:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 05:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQBvs9PWy0WEQre2DbdF0OTKYft1K59Iv3t8NAA2BXilrHpuYyVmSmLjXmzMUS8t8SSAEHdtdeGtQuKA8YWj9636YDK3e3uBurldRReGymRhyKmXcqSWhuNh2/naSChRfqBw0z6kKWP07nonDoUSJHGIRDgffC/rHd7lel9iYhgubt1cConS7wPsIof3HvdhGCDDNwriEeJokROWjt2W1AhCvwKFud5T7/A8s1sFJl86X+Zo7zCmYZAKDpb6oKIAFTfnphDcAf529jRPFqmwRzuDGJkZw5fygQyn99lYZPR0DcW0xSCcG95mB3jow9xUjcv0OMLrynKZz7zIvqPuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfnE7EH3+oZ03y/HjcU2sK1220pd9JI5H3fxM53Mo2c=;
 b=NfstFvRr7tqhIEgDPQFFJe1RQN4UkygiySq5snu6HKIaZEQxMeFKDYKkNjkti3Bho+9SsPUTsGEPrrIld9AiDlEPGd+qWyAhl50I+ESBDjnUxtp3cg9x5LLWrLQZQwVMrfE+EhtPaBkMGc49oMDHuL+5WIXeRrTdAtduODps3SIjxw1OdnYIUgLXPyt1r/iN/C1EJ+irHu7LfzSETaZfzSDV76Smr05OrPM+jt8kUdiA7G0CQ9VvRFbcQXx+Xv8UiUwNCffE+lceGdiDDNvS+7M8C4xOZgVzBRqB/1XTHlivv2L7nZ++ya9qbhzFY1M+fSbZMed6bNkjEMKGr0Paxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5)
 by CH2PR11MB8778.namprd11.prod.outlook.com (2603:10b6:610:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:04:43 +0000
Received: from MW4PR11MB5870.namprd11.prod.outlook.com
 ([fe80::8fc2:1b87:3f4:6343]) by MW4PR11MB5870.namprd11.prod.outlook.com
 ([fe80::8fc2:1b87:3f4:6343%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 13:04:43 +0000
From: "Mohan, Subramanian" <subramanian.mohan@intel.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: "rcsekar@samsung.com" <rcsekar@samsung.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"balbi@kernel.org" <balbi@kernel.org>, "Tan, Raymond"
	<raymond.tan@intel.com>, "jarkko.nikula@linux.intel.com"
	<jarkko.nikula@linux.intel.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "lst@pengutronix.de" <lst@pengutronix.de>, "Hahn,
 Matthias" <matthias.hahn@intel.com>, "Chinnadurai, Srinivasan"
	<srinivasan.chinnadurai@intel.com>, "Mohan, Subramanian"
	<subramanian.mohan@intel.com>
Subject: RE: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
Thread-Topic: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
Thread-Index: AQHbYav7t4vhhBQxfUSHUYsRNHo2ZrMOlyAAgAXxj1CAAs8GkA==
Date: Wed, 15 Jan 2025 13:04:43 +0000
Message-ID: <MW4PR11MB5870A2300CA4571C1C66B317F7192@MW4PR11MB5870.namprd11.prod.outlook.com>
References: <20250108090112.58412-1-subramanian.mohan@intel.com>
 <fzbw7i5wrpngg4ycapbo2g4b6d7ecykj4an3flcrxgwrp5t6cr@ogqcnsnvlwi2>
 <PH7PR11MB58625A0D029BB135A9F506C8F71F2@PH7PR11MB5862.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB58625A0D029BB135A9F506C8F71F2@PH7PR11MB5862.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5870:EE_|CH2PR11MB8778:EE_
x-ms-office365-filtering-correlation-id: b3acf8a3-45b0-4858-e714-08dd35652e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XHDBfdcWYmSvMkonBm4QarEG5bVgRgtAdQPsNJX2R303+fl8OiQBt8bifL?=
 =?iso-8859-1?Q?8NJxOXxlFwe3ibX8qXsKkvCdAyCEHI/pK+VvXnqktsp2W9Z4WWBgTCDoZo?=
 =?iso-8859-1?Q?r2PEzn9nDqtBoqmj4UHWRQl5vKupM2w3bsKAUBM4K1yHd8Xm/EphRYzpsY?=
 =?iso-8859-1?Q?JD5MsaPhb5P3SoteWKNrKjtW3T3q7DidoVbd1Pr8DCR1laT7S/Ng7bvDn1?=
 =?iso-8859-1?Q?CRrs79V0kQVkdEq0gqWsA6O/Xr/ag4S9H/z+By3FFe4e7Iua/Wu9Dz4KKv?=
 =?iso-8859-1?Q?+l8Gk+7qhlc1BxiLp92gOCADvmwlou8cezsPGe0JBwFRoNLX3QpZEYRQel?=
 =?iso-8859-1?Q?AmHZ0mHA7lR5LLfMNUFsGBG4Z1I44pWAAVdgcljAcnrKvpkoF5B+3oFehx?=
 =?iso-8859-1?Q?X8iJOZ562nSI3NTxnz6dxhlppjRlFbx9ZF536rOoD4HoY8BA8mqVj0qqeS?=
 =?iso-8859-1?Q?LRcrFjSJf0l6emx8NeAul69J2MkLLC/EVz/1kLbULdKOF0I1yOZwINJ8Wj?=
 =?iso-8859-1?Q?JltIUf+y1yAVjXY4sh66DOexqtvD+KotQxk0QcblHdJxSXPkxqNngBm/g9?=
 =?iso-8859-1?Q?93RerxRxt/Og5Sxp+ChlkGXWHlt9mOF0IJq4wn9Z+qzoWGcuPO6fnT57VV?=
 =?iso-8859-1?Q?FclcJ5mfe7Glt7+ScYTH+mreeSLt0dRS6Z7d+ntUlMyVmeyxiVZXONEJ6M?=
 =?iso-8859-1?Q?eVdJRrMqQq1XQ5tHnIJY5ttRQ58d3U7zprMvwpJyj5ArAV3I+0qAnyV2U2?=
 =?iso-8859-1?Q?WeyVYYaWlfHkg4XuXAbvB15a+y9F4Hc+Q9z+xghZK7bdsY8xhTL2o35VgW?=
 =?iso-8859-1?Q?fumWpHxATAMo1omPfF/WFWqNRaja2YyKfX4kyIrK39YMOFWG29xQ8Xl/qk?=
 =?iso-8859-1?Q?tMO+zKBpb4jsysmSzJUw7yAMWTLu+AG1QRlYTWHiALDyXmJQ1ov2zc6gI2?=
 =?iso-8859-1?Q?X2fePWugKNmqzDd9PaWTp0Jva+Z+7Fjw9IsAyrCU00a0ZIqsoEkC225c0t?=
 =?iso-8859-1?Q?VP3j8un3GjqJe9hZ8HqBST1IYO+kfx7FPpek+w3vPDUmwDmk7ObGRk9hTD?=
 =?iso-8859-1?Q?hfgpcangpbJRUl0sIV6jzakAZ2yD6LJVNbvXIjrHoZKvU5qJydj72E9rci?=
 =?iso-8859-1?Q?1w6KwgOiiGM9FnmwW28CntSHn93PcfLOj37eiPbW+zjNbLrIoGp6B+QX5g?=
 =?iso-8859-1?Q?oJGrGwKmEuHWepasWIlcfQUyKV/miGq80C3YwAX2yoCKY92qUXXPc9tpvP?=
 =?iso-8859-1?Q?m27TMctkHsKv2U9g8dksBjXw0CxRS+WKaIrK9K9xKtNY5wdi8eE2C8Ub8x?=
 =?iso-8859-1?Q?cra27nA7F7PM1XMgnnqsIcMe2Shx6Ig4iqpG/IlPA827Ppm/ZKMPGvczxj?=
 =?iso-8859-1?Q?+gpvE+5Wbarsu2CZKWqa1sq7MTiwzThwUY6+Jmr6bIgYG1YkPlxABaC//u?=
 =?iso-8859-1?Q?SojTD9XadJ/Lo4ba/227HW05ogVWKPTFai3jsg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iOJ+R1Ko3g6qga5iiTMDukvEzY6Qa99HJcTLvsmkfUskB3ncvkCJxKhLkn?=
 =?iso-8859-1?Q?FTyAUyT98+4apW0oLt40KcH0x25VQgKz5h4Mhnbw1lpR4sX+yABQxKRGq6?=
 =?iso-8859-1?Q?IAtoNB4YQRGqBM4VNUwz9hFW05X5y32hTo2RUZcy9fanH34Q3RE01QwWTw?=
 =?iso-8859-1?Q?h9tcP61mF7DJshaXYou1NOcCauF4Rh1+SfeG06fSwnpuqZe8bxIAEVqK1w?=
 =?iso-8859-1?Q?9molvUe5iZHZ6a5GvF/8lDu2YHbzMIYJffGq/w1b9n15ZmEUjwjP4RSXLh?=
 =?iso-8859-1?Q?J0J6hl0uTkaSeFRrMfpPQzRG07HAjMokXcFPWq/E0VBL9SWK+MK7ukAUMN?=
 =?iso-8859-1?Q?OzBpAHu9Ajy/U/O2ZVgl30jEemRGeAtJUE5Xp/ckGFbvHuoCzZtkf/9X0M?=
 =?iso-8859-1?Q?37vcfngm6D0uw43dZ6pwnXDxlqd/DNhlI+63sAZTfw6JFKVawc0rGjoUs5?=
 =?iso-8859-1?Q?Bcalhc78OChLqCf4LRz2PP+iMAfb2Bpk1qjuv1UyeW959XsoFV9XysJj9/?=
 =?iso-8859-1?Q?Ci5ybYHaVIVAgYIko77L3Ato0mU5y89cUuILSR+JiLQiF2wPytNTrAFRCN?=
 =?iso-8859-1?Q?YUgF+hsLCjmH7lAEF7ZOnBNOjxlU2AEsKwDihRbEADGdKWjYxVFITKSkZX?=
 =?iso-8859-1?Q?8XlLw2Yirl8nsDuzPjAONu042EWZbwa3KkPv0U6REGjmqbfzUWMH+TD+l/?=
 =?iso-8859-1?Q?Tbmbvx6BDZww6qunyXo6Gcl67J5rzuAr0tVcnTySqoVQLN/m4qmLcb2y4t?=
 =?iso-8859-1?Q?Dx0yhRhnuMQb6CN3aECsbnBI4oSqa2H/l18m6CMaz1EzTmwxBeoxh1yUyp?=
 =?iso-8859-1?Q?VESfBeXnbtyFIkW3HWzVf+j5QKA3aKyxPPEREyWOU0t3/6IwY6+0Y3H6G2?=
 =?iso-8859-1?Q?KiRQJBfu4sUTGueFKyoy82tsG07LIdSmaeNdKNpiNCGh+LkBs1j/G+nyWe?=
 =?iso-8859-1?Q?razLgykWbT+gjYvzf0fu0TW8RHH/LwqGvXDi6hNE+D2jYX96Tm+l722bvt?=
 =?iso-8859-1?Q?gIc3Tfbk9HTbu8BxjT88LiPumx5D09A6x+D5oulf6aah+5YnJcaZjg09Qj?=
 =?iso-8859-1?Q?6qW/UGJR3knSR0i76bfYEmUWUb+G1Ifu9jgSj93R7TWz6AiQd6bveQ0tUG?=
 =?iso-8859-1?Q?mzCQ5F/BnE1lN6lSb3W976vYCLbqviHTrVYyZfxFRt0mefZotugZhMlP+y?=
 =?iso-8859-1?Q?q7Y80cSsKzCUu2X4uh1UdYBh1MrXLGCHN+OlsqABAffJnmpot2nxS6OAa8?=
 =?iso-8859-1?Q?8ogCTeqcvrLQzrWlOet95fOQwWvFf2o5Iy2ckeTVLIRPXIeoyTHqU4/F6O?=
 =?iso-8859-1?Q?tzTxwI9+a5/FIb24//sjyRUK0o3HubbaxKupRvX7anWtmz957Csb8ue2KS?=
 =?iso-8859-1?Q?svqvmx/5igfh0dXLvspyCxZKwVVhLGXypInNr0ppCtRIw8rEBpptj0op6p?=
 =?iso-8859-1?Q?hWfOlHpEF2gaUxHdzplxm3WTvFzdn2iWqJZO6ad15kETeoTwDYP2IahyuB?=
 =?iso-8859-1?Q?rS7onBoEQWUEPsiY6eLm9/OFAYsQ7a4XW4R0Lq6HW7+OsVQH3Se4jGHwsC?=
 =?iso-8859-1?Q?UbvZE2I1PCkf4bF8TbW2tJUnCs7fLvv4AA7tmPNlVTC7dfbE5HGsr8CEeX?=
 =?iso-8859-1?Q?6vCx85pWFlirTqbTLEBkufQ0p9EBMMlcqU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3acf8a3-45b0-4858-e714-08dd35652e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 13:04:43.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uFAbSVrtDdcm46F+7FMwiBSDQN3Inz/ir+qiezgdwkcywMQxM+vZJdQYauEhzot0gEHgSfxAlkgxHLWEEP+7hE5bVmuXH18GqUgeU05LCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8778
X-OriginatorOrg: intel.com

Hi @Markus Schneider-Pargmann,

> -----Original Message-----
> From: Markus Schneider-Pargmann <mailto:msp@baylibre.com>
> Sent: Thursday, January 9, 2025 9:14 PM
> To: Mohan, Subramanian <mailto:subramanian.mohan@intel.com>
> Cc: mailto:rcsekar@samsung.com; mailto:davem@davemloft.net; mailto:edumaz=
et@google.com;
> mailto:kuba@kernel.org; mailto:pabeni@redhat.com; mailto:balbi@kernel.org=
; Tan, Raymond
> <mailto:raymond.tan@intel.com>; mailto:jarkko.nikula@linux.intel.com; lin=
ux-
> mailto:can@vger.kernel.org; mailto:netdev@vger.kernel.org; mailto:linux-k=
ernel@vger.kernel.org;
> mailto:linux@ew.tq-group.com; mailto:lst@pengutronix.de; Hahn, Matthias
> <mailto:matthias.hahn@intel.com>; Chinnadurai, Srinivasan
> <mailto:srinivasan.chinnadurai@intel.com>
> Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message stu=
ck
>=20
> Hi,
>=20
> On Wed, Jan 08, 2025 at 02:31:12PM +0530,
> mailto:subramanian.mohan@intel.com wrote:
> > From: Subramanian Mohan <mailto:subramanian.mohan@intel.com>
> >
> > The prolonged testing of passing can messages between two Elkhartlake
> > platforms resulted in message stuck i.e Message did not receive at
> > receiver side
>=20
> Can you please describe the reason for the stuck messages in your commit
> message? I am reading this but I don't understand why this happens or why
> your proposed solution helps.

Let me describe problem bit more:
We are using 2 different Python Scripts(client and server) on both of the E=
lkhart lake connected systems.=20
The "server" script sends out messages with Arbitration ID's, and then wait=
s for a response. If the Arbitration ID is different than the=20
one expected or no message arrives it logs an error.
The "client" script listens for messages, and depending on the Arbitration =
ID received it sends a message with a specific Arbitration ID back.
We have deployed both the scripts in 2 different systems and triggered the =
testing
If any message is lost/stuck then the "server" - Script will log an error.
The Message stuck corresponds over here, whenever the server sends out mess=
age and waits for reply, we wont me getting the reply message=20
On the server side. Even though time slice increase in scripts did not help=
. On further debugging enabling TX/TEFN impacts the processing load.
To overcome this we disabled the TX/TEFN interrupt once processed and enabl=
e it back in the TX start xmit function.

>=20
> >
> > Contolling TX i.e TEFN bit helped to resolve the message stuck issue.
> >
> > The current solution is enhanced/optimized from the below patch:
> > https://lore.kernel.org/lkml/20230623051124.64132-1-kumari.pallavi@int
> > el.com/T/
> >
> > Setup used to reproduce the issue:
> >
> > +---------------------+=A0=A0=A0=A0=A0=A0=A0=A0 +----------------------=
+
> > |Intel ElkhartLake=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |Intel ElkhartLak=
e=A0=A0=A0=A0 |
> > |=A0=A0=A0=A0=A0=A0 +--------+=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0=A0=A0=A0 +--------+=A0=A0=A0=A0 |
> > |=A0=A0=A0=A0=A0=A0 |m_can 0 |=A0=A0=A0 |<=3D=3D=3D=3D=3D=3D=3D>|=A0=A0=
=A0=A0=A0=A0 |m_can 0 |=A0=A0=A0=A0 |
> > |=A0=A0=A0=A0=A0=A0 +--------+=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0=A0=A0=A0 +--------+=A0=A0=A0=A0 |
> > +---------------------+=A0=A0=A0=A0=A0=A0=A0=A0 +----------------------=
+
> >
> > Steps to be run on the two Elkhartlake HW:
> > 1)Bus-Rate is 1 MBit/s
> > 2)Busload during the test is about 40% 3)we initialize the CAN with
> > following commands 4)ip link set can0 txqueuelen 100/1024/2048 5)ip
> > link set can0 up type can bitrate 1000000
> >
> > Python scripts are used send and receive the can messages between the
> > EHL systems.
> >
> > Signed-off-by: Hahn Matthias <mailto:matthias.hahn@intel.com>
> > Signed-off-by: Subramanian Mohan <mailto:subramanian.mohan@intel.com>
> > ---
> >=A0 drivers/net/can/m_can/m_can.c | 11 +++++++++--
> >=A0 1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c
> > b/drivers/net/can/m_can/m_can.c index 97cd8bbf2e32..0a2c9a622842
> > 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1220,7 +1220,7 @@ static void m_can_coalescing_update(struct
> > m_can_classdev *cdev, u32 ir)=A0 static int
> > m_can_interrupt_handler(struct m_can_classdev *cdev)=A0 {
> >=A0=A0=A0=A0=A0 struct net_device *dev =3D cdev->net;
> > -=A0=A0 u32 ir =3D 0, ir_read;
> > +=A0=A0 u32 ir =3D 0, ir_read, new_interrupts;
> >=A0=A0=A0=A0=A0 int ret;
> >
> >=A0=A0=A0=A0=A0 if (pm_runtime_suspended(cdev->dev)) @@ -1283,6 +1283,9 =
@@
> static
> > int m_can_interrupt_handler(struct m_can_classdev *cdev)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D =
m_can_echo_tx_event(dev);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret =
!=3D 0)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 return ret;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 new_interrupts =
=3D cdev->active_interrupts &
> ~(IR_TEFN);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m_can_interrupt=
_enable(cdev, new_interrupts);
>=20
> Here is a theoretical situation of two messages being sent. The first is =
being
> sent and handled in this interrupt handler. Then it would disable the TEF=
N bit
> right? If the second message wasn't done sending yet, how would it ever c=
all
> the interrupt handler if the interrupt is disabled?

With this patch we are controlling only TEFN/TX interrupt bit, rest of the =
interrupts remains unaffected.=20
Since We are enabling/disabling TEFN bit only, interrupt handler will be ca=
lled normally with other interrupts.

>=20
> Also you are disabling this interrupt here regardless of the type of mcan=
 device
> and also regardless of the coalescing state. In the transmit part you are=
 only
> enabling it for non-peripheral devices. For peripheral mcan devices this =
would
> also introduce an additional two transfers per transmit.

TEFN bit enabling/disabling applies only to non-peripheral device.
While disabling the TEFN bit in interrupt handler, we will add the check fo=
r non-peripheral device before disabling it(V2).
On the coalescing state, The snapshot is already taken while entering the i=
nterrupt handler.

>=20
> In which situations is this really necessary? Does it help to implement
> coalescing for non-peripheral devices?
This helps in heavy load/traffic conditions=20
Not exactly sure on the coalescing part.

Thanks,
Subbu

>=20
> Best
> Markus
>=20
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >=A0=A0=A0=A0=A0 }
> >
> > @@ -1989,6 +1992,7 @@ static netdev_tx_t m_can_start_xmit(struct
> sk_buff *skb,
> >=A0=A0=A0=A0=A0 struct m_can_classdev *cdev =3D netdev_priv(dev);
> >=A0=A0=A0=A0=A0 unsigned int frame_len;
> >=A0=A0=A0=A0=A0 netdev_tx_t ret;
> > +=A0=A0 u32 new_interrupts;
> >
> >=A0=A0=A0=A0=A0 if (can_dev_dropped_skb(dev, skb))
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NETDEV_TX_OK;
> > @@ -2008,8 +2012,11 @@ static netdev_tx_t m_can_start_xmit(struct
> > sk_buff *skb,
> >
> >=A0=A0=A0=A0=A0 if (cdev->is_peripheral)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D m_can_start_peripheral_x=
mit(cdev, skb);
> > -=A0=A0 else
> > +=A0=A0 else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 new_interrupts =3D cdev->active_interru=
pts | IR_TEFN;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m_can_interrupt_enable(cdev, new_interr=
upts);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D m_can_tx_handler(cdev, s=
kb);
> > +=A0=A0 }
> >
> >=A0=A0=A0=A0=A0 if (ret !=3D NETDEV_TX_OK)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 netdev_completed_queue(dev, 1, f=
rame_len);
> > --
> > 2.35.3
> >

