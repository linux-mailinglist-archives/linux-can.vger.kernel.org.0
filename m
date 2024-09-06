Return-Path: <linux-can+bounces-1427-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57696FCF6
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 23:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759A61C22358
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C25155741;
	Fri,  6 Sep 2024 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="YsJU8ozA"
X-Original-To: linux-can@vger.kernel.org
Received: from us1mail02.teledyne.com (us1mail02.teledyne.com [140.165.202.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678451B85DF;
	Fri,  6 Sep 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.165.202.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656558; cv=fail; b=FqpxBpiP0CnhH6iWIl+W53E+efLKgMlnv7SY98rqVHeXn46aoYD8As7HfLtDlSXUbeZJayohYnPg7GSaUX7F5ZwKP/bqLQuqnt820pf5XqAkEfo3WKtYYpUWRKzQfyZhhnKAlcBt8+8yutWVFnMtnvC/b/ekA0siBsXz586Qm1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656558; c=relaxed/simple;
	bh=MmAMTebFe3VS4t4UsZ6k1Wfz6yTE32caLYZ4uj48mxw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XYvAXoBrr6QiTt5lvjsEiDX3Kb8lgNBq6al/eRBB17s0pi1k46CZvJwgL8Ti3VnnbCajqUdGipSsiSaCvGky6eTiQ8Pqjsh/TL5N+h4N3BOj2LE1X1uFB4ygeS2Ym9e7bWAdD8x+tAiRQWJvIFTmv+bUXyzZBjSb/G6/sghitjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=YsJU8ozA; arc=fail smtp.client-ip=140.165.202.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725656557; x=1757192557;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MmAMTebFe3VS4t4UsZ6k1Wfz6yTE32caLYZ4uj48mxw=;
  b=YsJU8ozANAXcVLkh4Kol6AG0aS/PROD3LWmYwDjT5l7KhJ1Xlal/RzbR
   bkKKTZzsMqN78tvo0G48fRtL/6g66sMSj1mWbW4eo/oaQZ5nMBrqpbqzF
   EMH4AcqGtZ//AuSBUc1GA1VVcntQZ5H3lJTFopOOKe272q6ChLAqiVFNy
   xVTzAtFZ58ZcRJWP6fO92Ur3ltnof1hbhfC41HSXMdgixUfa5ujv3yRHx
   /KHzuXtiwwBBopXSIQAQPo1djjJCh1af83/7+Ea4F7Jc7yD3mD90PF+qq
   JHlFi0c8PVx2282CTgraby4Elcwb7bFWc3YsMzdCzjALyvcF9hWzdrTQS
   w==;
X-CSE-ConnectionGUID: 6jzTTikZR4SOu8iFw/076g==
X-CSE-MsgGUID: jDF9zXYwTEiXCR+K//iQOQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:YHtt1ahsJ25B0Y0EUnaIM2ACX161ZREKZh0ujC45NGQN5FlHY01je
 htvWGuPPq2NNmL3c9ojOYjlpElQ7JaGn4NgGgM+rCs9FHwW8JqUDtmncnv9bniYRiHhZBs/t
 ZlGMoGYRCwXZiaE/Ev1auC5xZVY/fvVLlYpILecYkidfSc9FWF8z0slw7Nk6mJRqYDRKxuXv
 t/vqNHoNlag2jplWkoZ8KvrRClH5ZwehRtD1rAATaES1LPhvylNZH4vDfnZB2f1RIBSAtm7S
 47rpJml/nnU9gsaEdislLD2aCUiGtY+6iDX1xK684D76vRzjnRaPpQTbZLwWm8O49m9pO2d/
 f0R3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZX7I0Er7xIAahihZa07FdRwxwp5PY1B3
 aIaOgwxbxOxvb6N56/rS8dzwZx8csa+aevzulk4pd3YJcsdGNX9e4Dxypp99gdo3IZSEeeYe
 8cdZDZ+ahmGaBpKUrsVIMtixKHx2CS5KWEF7gnMzUY0yzG7IAhZ8rHuPZz1c9mAVO1Jk0KVq
 nPA8iLyBRRy2Nm3kGvdoyr82b+V9c/9cIA+Ouyqxs91vHCS9kcpSz5RElqChsDs3yZSXPoac
 ST44BEGqak06VzuRdD7dwO3rWTCvRMGXddUVeog52mlzqvS/hbcBWUeSDNFQMIpudVwRjEw0
 FKN2dTzClRSXKa9VGnEs6mMqCi9fC0fPTdYIzMIXE0Z7t3urJA1g1TESdML/LOJs+AZ0ArYm
 1iixBXSTZ1K5SLX/81XJWz6vg8=
IronPort-HdrOrdr: A9a23:U4bln6O1zpOwIcBcT0n155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjzjSWE8Qr5K0tQ4exoX5PwCU80lKQFqLX5Uo3SOzUO1FHJEGgA1/qo/9SDIVyZygc178
 4JGMIRaeEYZWIKyPoSizPIcerIteP3lJxA8t2uqkuFIzsaCJ1I3kNcMEK2A0d2TA5JCd4SD5
 yH/PdKoDKmZDA+ctm7LmNtZZmIm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYZ93
 TfmQCR3NTvjxj78G6R64bg1eUZpDLT8KoDOCVKsLlUFtzYsHfmWG2mYczAgNl6mpDs1L9gqq
 i2n/5pBbUI15qWRBDwnfKl4Xid7B8+r3Dl0lOWmn3lvIjwQy87EdNIgcZDfgLe8FdIhqAJ7E
 tn5RPqi3NsN2K0oA3to9zTEx16nEu9pnQv1eYVknxESIMbLLtct5YW8k9ZGIoJWHuS0vFQLM
 B+SMXHoPpGe1KTaH7U+mFp3dy3R3w2WhOLWFILtMCZ2yVf2Hp500wbzsoCmWpozuNLd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTnfARBrdWVjiUmgP1Jt3S04lh6SHkYndvtvaB6Dg5KFC5q
 go5zljxBMPR34=
X-Talos-CUID: =?us-ascii?q?9a23=3ArjS6vGkbPb2lX3APgeYX/jQkU3PXOSPf3kvsIky?=
 =?us-ascii?q?KMzpSb6DFSHGPv/s7zcU7zg=3D=3D?=
X-Talos-MUID: 9a23:LgWTiwTPy5JTpCSYRXTuqB8zJvdZ/JiDCXAmq9Yl/I6FDAtJbmI=
Received: from us1-vpmsg-mbx02.tdy.teledyne.com ([140.165.245.31])
  by us1mail02.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 14:02:30 -0700
Received: from US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) by
 US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 16:02:29 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (140.165.200.224)
 by US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 16:02:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRuDn+Q4Zps47nWBxO6dXN7oSIWVKQ3wmIFqvISNCSqBbonb++TrWNuUL6fFUJZLq+05c5M1hQlG8M02kEGk+cl2Mq2W2vh2xSTZgQVJ5/uNg7o3zmEOiA+9rm9U5LuxKU0bzT2Vgt8cgQcNMJM+T92e/XnFd7IepxJcqLfAy2n/xawYpIEgRbjCTj5B8kdUiODytcGTGrfkE029VDurf1M1Q+b3RJ7Q9vdLKCnBZV1w2rlIP9YXX8nyTTzLC5PlOBiSX3vPdxl/qMXEpUhV6ln1Gy9rbC8PbnVs9Tvlgt4y2hTgbY1ScY9MU+qI1xIX9vfHyVveSaw/LfiGvES2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am5/uy5QLQL7joHPges8GBMadkoj5dQu4N0L3r7/B8k=;
 b=JdJUZ1fsmFRVqMrUx+UM1WN+PCRCmY07HJqCdT4IYRSOFkqrOpYEUg9WlFbtmMdZVG4ZStdnv+2kuvGQJKFz0ZahZqZZvTJaZ7rHNQ5a+Iq0HUP/TDRBvQBLx90BiO5V4tNfW1zbrtWRSsb9L0HmmNPW7gygt0/lVb0bgmiLuUT/abx1SYgwe5lEsnUGI7aGkJh2X7fbR2w3ByGFB/H0XJJqG96lV4KgCHUcpaxQ57twVvd6GmnVdHTN4mzMAXFrFwE7sUtWJ8pTBhS6dN85Ma2LnAybcrjKKFfs4YrBwunOQ1n5RDwXrrJjzNasGjXA9GLa8bQ6dZ8r+54WLRdK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from CO6PR14MB5217.namprd14.prod.outlook.com (2603:10b6:5:359::24)
 by CH3PR14MB6346.namprd14.prod.outlook.com (2603:10b6:610:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 21:02:26 +0000
Received: from CO6PR14MB5217.namprd14.prod.outlook.com
 ([fe80::75c6:11dc:2103:8ae6]) by CO6PR14MB5217.namprd14.prod.outlook.com
 ([fe80::75c6:11dc:2103:8ae6%3]) with mapi id 15.20.7918.028; Fri, 6 Sep 2024
 21:02:25 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAn7k9Dbr6YPKJR5aTkz9U5cNmMg==
Date: Fri, 6 Sep 2024 21:02:25 +0000
Message-ID: <CO6PR14MB5217EC2D2C791F527CEB40C3EF9E2@CO6PR14MB5217.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-titus-metadata-40: =?us-ascii?Q?eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpc?=
 =?us-ascii?Q?L1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ZMSVIiLCJpZCI6IjA1YzBhYTVhLWVi?=
 =?us-ascii?Q?MjMtNGY5OS1hODhiLWRiY2Q3NjE1NzdlNiIsInByb3BzIjpbeyJuIjoiRUNJ?=
 =?us-ascii?Q?RGF0YSIsInZhbHMiOlt7InZhbHVlIjoiTk9vckVBUjk5In1dfSx7Im4iOiJF?=
 =?us-ascii?Q?Q0lKdXJpcyIsInZhbHMiOltdfSx7Im4iOiJFQ0lJVEFSQ2xhc3MiLCJ2YWxz?=
 =?us-ascii?Q?IjpbXX0seyJuIjoiRUNJRUFSQ2xhc3MiLCJ2YWxzIjpbXX0seyJuIjoibm9u?=
 =?us-ascii?Q?VVNDb3VudHJ5IiwidmFscyI6W119LHsibiI6Im5vblVTRUNJSnVyaXMiLCJ2?=
 =?us-ascii?Q?YWxzIjpbXX0seyJuIjoiVW5yZXNDb21wRXh0IiwidmFscyI6W3sidmFsdWUi?=
 =?us-ascii?Q?OiJOTyJ9XX0seyJuIjoiQ29tcFNlbnMiLCJ2YWxzIjpbeyJ2YWx1ZSI6IllF?=
 =?us-ascii?Q?UyJ9XX0seyJuIjoiSW5jbHVkZUNvbXBTZW5zTWFya2luZyIsInZhbHMiOlt7?=
 =?us-ascii?Q?InZhbHVlIjoiWUVTIn1dfSx7Im4iOiJDb25mTGVnUHJpIiwidmFscyI6W3si?=
 =?us-ascii?Q?dmFsdWUiOiJOTyJ9XX0seyJuIjoiUElJRGF0YSIsInZhbHMiOlt7InZhbHVl?=
 =?us-ascii?Q?IjoiTk8ifV19LHsibiI6IkNVSURhdGEiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5P?=
 =?us-ascii?Q?In1dfSx7Im4iOiJDVUlDYXRlZ29yeSIsInZhbHMiOltdfSx7Im4iOiJEaXNz?=
 =?us-ascii?Q?ZW1pbmF0aW9uIiwidmFscyI6W119LHsibiI6IlJlbFRvIiwidmFscyI6W119?=
 =?us-ascii?Q?LHsibiI6IkRpc3BsYXlPbmx5IiwidmFscyI6W119XX0sIlN1YmplY3RMYWJl?=
 =?us-ascii?Q?bHMiOltdLCJUTUNWZXJzaW9uIjoiMjMuNi4yNDAzLjEiLCJUcnVzdGVkTGFi?=
 =?us-ascii?Q?ZWxIYXNoIjoiU2hzM3BkU05pUktQU3dnSmMyNHpFU0Y1Z0IyN2Q3aG5wdFI0?=
 =?us-ascii?Q?bHpGdm50QTZKc2Z1dDNKN0xJOU1rYUJNTnhUMSJ9?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR14MB5217:EE_|CH3PR14MB6346:EE_
x-ms-office365-filtering-correlation-id: 3873acb9-3ead-4a40-220c-08dcceb735b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?40LUMpqvCq8lanszaLV7mUFElFeTzZnh1UIS3p7RcHFzYUmT0DU6Fm4p+5iL?=
 =?us-ascii?Q?dIWS1rQ9uB0QNVhXOyWksr6OVV72+AxrQYXKSR3nPEk39jAzjK30vkZs/dyf?=
 =?us-ascii?Q?Gh2S2CZi46ipCpV9fmAQrjUKHE5WsEElV5cZLEdwCUWROeHJFqPgl6Kj/6sq?=
 =?us-ascii?Q?Iv3NkmketJORM6HPWV/XwE49iGVmX0lj8Q+p0VVZrfJdSVgfKIjRlUtXoQwq?=
 =?us-ascii?Q?NaCBsnEKGrVhbBN5F07nR6ZgKL125KCYDFbgFxwyLs66KTWq//ZGEfpqGXF8?=
 =?us-ascii?Q?cXFLgPQ8UbZB57Hc3IaUkPdFWWurZggWPQQTB4CIuttGB9YzjioZcc51FSv1?=
 =?us-ascii?Q?NBU2zhLh23ooMHv0M2MiERoTll6TvCwEtNSv34YYTP3pYypCvJYEGUOXOk20?=
 =?us-ascii?Q?v9I4kZt0SMKJ+cZuAswa0sW+BqPubCVLwp0Ai9ByuWOyeb3Ato6sctNPvUSV?=
 =?us-ascii?Q?dSPM2tD5mUQKletefPe4kbGE4e9TDKciq47uKYotYuj5+2PT2J+o28OetIj8?=
 =?us-ascii?Q?tdDfUZ80tY3vYVE0YOC74jDnP+bNbyDa3oW9JTHwkg84xuHQOF3BSAjOjh1s?=
 =?us-ascii?Q?iEY1VhO5xuBmuz95PlkVdcq0Z4neingnY45Bp+NGlPKdfxcDfYPUIMVpXsyj?=
 =?us-ascii?Q?hRBAc0ezlYTH8bsxNhcNqgt2tmfegCDmb1xib4k20GXIXwk3dG2ckW4sgtio?=
 =?us-ascii?Q?xQWRbVo/5pIp1A6GOhbBHNP/A956/pg4Mk9wDJLiBk58wJhlh4SbETc0IKdZ?=
 =?us-ascii?Q?ihE1f2ld2SWZptuaVjqDIUikLVOM1VV0nbj00nq32453CcccqSZNADprgEpz?=
 =?us-ascii?Q?g13Lmr3WWchTQx4RvVBTdbYsNszf4mVSqpTIg8N/CvVWR9/GscHV5tyxr2Kh?=
 =?us-ascii?Q?Wjzji2R2VsDCHKyZRRRs0OdLkI/M8pGFYVBjuzVGqx/IWyU2p2wsCl3vMa/J?=
 =?us-ascii?Q?pX1zmx9flEwEtNRRj5BEQd08O9nwp67fKXLQr3ncbdglg2sqbijBO9BNM2C4?=
 =?us-ascii?Q?Ef582a9FpPsdyZsxo7R76u+2tUmf4NMnSTSlRisTMTWCGROED+lO50Nv7Fcn?=
 =?us-ascii?Q?OSck9yzxWoCOzxUna221Z4UzrJTlgSylyFJkitxbapmRQcVbKPEs+tynSWK8?=
 =?us-ascii?Q?IxhXwFKFjVRbZd6P9aJ7s2foNaQkb+eBp01ensjmJv2jj4RTMyOjjN1ZbrhI?=
 =?us-ascii?Q?090CHSnnoqAq7DFL+aND37P/hu8vG5LnyvJwcLZTL779QlnkHqDMsCr8UHqC?=
 =?us-ascii?Q?ICsrdFhrQZAhqJPrBF9x84tR5xF0Mt0aJiTbcdVV6h8GKWjCkgWwz9XhJEhK?=
 =?us-ascii?Q?FmgsD//N1c6oFhjDLoZOkCl2SKk8fYMxGpIJX0FTmdRtnsyIHUFEJ9gOTlQV?=
 =?us-ascii?Q?VHyDRmFXdLPPHYnv5q8/hwFJHeouyv+1QbfV5O26wgDO7j/pJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR14MB5217.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dGX++5TEJQv4h1MxjDghUqqdVU4PLfbi7+Qgo72QMvQAc6LYciKZo/Q5z2i4?=
 =?us-ascii?Q?DlNIRR0391ExGTUX8RQQtIis1k1a1XWPotQ9GcXUVeMWC7k2yG7SbgnDjXzf?=
 =?us-ascii?Q?mnjWkMjNaZusTFJbSkcJIK72OtPxjskS3nzB2GPMqMa0iNXlTPE9O+NWytKt?=
 =?us-ascii?Q?P7l63W9UOWMscniii9dlpSd6n0zaZ3n8hZZ/VsXvzF69pjFXdwWm0SsHKT61?=
 =?us-ascii?Q?AvNa/xRkGSw39M51S3Ozk8sTWMSzXypv2IqB5SKWvN9kZrC4qqLUbr0/OMM5?=
 =?us-ascii?Q?RE8i36I/N7IDBjNTTRDcQCG9e6wjbrAspIr3CW02wxnQ11Q6hqqzpP48CxD0?=
 =?us-ascii?Q?eeETyKBkZ2lwE9I7IFr+D78iUUncaX/MVcY5R2Rjef6iPydPoq9FuV8/rHo4?=
 =?us-ascii?Q?fu6M7/ZooXDjg0IUL/mFCXvJPc6oRotPhX9HHMIlV0HZnbEWEzjvXFtbqrgR?=
 =?us-ascii?Q?URojzZ3e4QtyrVawX+9jN3AgiiDMVukqua4LjY35rZ/gCL+0AnLeMC3yRwY8?=
 =?us-ascii?Q?eplizwmWqC+EPG//uXekQbKbHWy/oAotmu13ct+k8RwNJd43+d0jiWBmSEiB?=
 =?us-ascii?Q?OUcMlZm8ADLNMUj+AUjh4LY2W/R1CF0FIcXjz2WLD/l3CTJCrJvsOEjKmpyI?=
 =?us-ascii?Q?CzZDAvJRD9i+vsPPtFIDwEbtF0F+/AIOxSZ8fcJfx64LhFS8tFNW8aHBYc+0?=
 =?us-ascii?Q?5B0pE1NfVtt71HXRn50rBX1xkpxh9y77OXwdaC+EA+TMJLH0dSfzeOmIuacQ?=
 =?us-ascii?Q?j3ix1rp7Gaig76fUSczy//9QQ294mElCSxXGj7f1pIyXQSqk5axmmjgS3Xwj?=
 =?us-ascii?Q?C9R3qO6q8IEtkZtI0HugHCKf0gHpIPEAvbm2UO2PgDMRI0eOI6hZ1CMl4mgS?=
 =?us-ascii?Q?so0EhBq1HrCArpRlqNCMe7CoWWoMwRYONvKCe2VFibBu4hLM1mXlWjZJSvL1?=
 =?us-ascii?Q?PhyHAin8nexvgh2FGHddfU32txVxTzRYhsIBJpEq+7aZQGs3+F6HZ/HmS7MU?=
 =?us-ascii?Q?Q1lPwg7fyT+ukm8fbyc/fIU70ZOwdvqkLaWNEqwGExl+6ABZXuS+hs/U8AHc?=
 =?us-ascii?Q?Zyc5/Xk0PnwrCrnoO9szoz9xyo+R80z3bylKdZbmR3wXcaBBtwWZZpFJ4E9O?=
 =?us-ascii?Q?uYv/Y2O44hl5ThksUgOmRrFxAA/w+vOqnf/P7vMScXXH1aX1QhLgQIGBYek1?=
 =?us-ascii?Q?jqK9RgTDD9bnylrzg+ezfw0cAJhM8BL1i5ayZYzByhm1rciILxtW26447oeY?=
 =?us-ascii?Q?94JVEtmcNDk5ZcB2Qvp74scR51M3D2uXVeqPBy7ONc8L62bBYMOcMU2iI7NI?=
 =?us-ascii?Q?b7w9F/dHU9ZORl6bNm6V0dklkrV0LH5cdK/dM1SRGK60LJkjvcMBpTAicnXj?=
 =?us-ascii?Q?SjjY6vEmuWomuML2woyS1eYWMPP5k8gFkqIYFW2L3GqL89t+72hoDefoa/Um?=
 =?us-ascii?Q?02pehEvNhJBIHID5YXt+fymYJM2H+lzGh50EMWn0lu9QHU7r6bf0zF5Pe2A4?=
 =?us-ascii?Q?ezAtaX6GT+Wct2AJirZgUw/a3BzqOWdU0zSYjHfwzqr2EF/9kZBiQYUXN24l?=
 =?us-ascii?Q?D4oF7SMY9L51ka7xhGTjE6q29MlwRZ8GDVppvFgB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR14MB5217.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3873acb9-3ead-4a40-220c-08dcceb735b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 21:02:25.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oifmgw/yR+Xy1In8n2t53t+/Xsxzj/CdWqiQOSE8MdfoO32GGu4WGCzFcILeLTzRKClkId0A0VA+1FtjMnMuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB6346
X-OriginatorOrg: Teledyne.com

If any error flags are set when bringing up the CAN device, e.g. due to
CAN bus traffic before initializing the device, when m_can_start is
called and interrupts are enabled, m_can_isr is called immediately,
which disables all CAN interrupts and calls napi_schedule.

Because napi_enable isn't called until later in m_can_open, the call to
napi_schedule never schedules the m_can_poll callback and the device is
left with interrupts disabled and can't receive any CAN packets until
rebooted. This can be verified by running "cansend" from another device
before setting the bitrate and calling "ip link set up can0" on the test
device. Adding debug lines to m_can_isr shows it's called with flags
(IR_EP | IR_EW | IR_CRCE), which calls m_can_disable_all_interrupts and
napi_schedule, and then m_can_poll is never called.

Move the call to napi_enable above the call to m_can_start to enable any
initial interrupt flags to be handled by m_can_poll so that interrupts
are reenabled. Add a call to napi_disable in the error handling section
of m_can_open, to handle the case where later functions return errors.

Also, in m_can_close, move the call to napi_disable below the call to
m_can_stop to ensure all interrupts are handled when bringing down the
device. This race condition is much less likely to occur.

While testing, I noticed that IR_TSW (timestamp wraparound) fires at
about 1 Hz, but the driver doesn't care about it. Add it to the list of
interrupts to disable in m_can_chip_config to reduce unneeded wakeups.

Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to any
SoC with a Bosch M_CAN controller.
---
 drivers/net/can/m_can/m_can.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01d..4ced830f5ece 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1434,7 +1434,8 @@ static int m_can_chip_config(struct net_device *dev)
=20
 	/* Disable unused interrupts */
 	interrupts &=3D ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
-			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F |
+			IR_TSW);
=20
 	err =3D m_can_config_enable(cdev);
 	if (err)
@@ -1763,13 +1764,14 @@ static int m_can_close(struct net_device *dev)
=20
 	netif_stop_queue(dev);
=20
-	if (!cdev->is_peripheral)
-		napi_disable(&cdev->napi);
-
 	m_can_stop(dev);
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
=20
+	/* disable NAPI after disabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
+
 	m_can_clean(dev);
=20
 	if (cdev->is_peripheral) {
@@ -2031,6 +2033,10 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		can_rx_offload_enable(&cdev->offload);
=20
+	/* enable NAPI before enabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_enable(&cdev->napi);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_wq =3D alloc_ordered_workqueue("mcan_wq",
@@ -2063,9 +2069,6 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto exit_start_fail;
=20
-	if (!cdev->is_peripheral)
-		napi_enable(&cdev->napi);
-
 	netif_start_queue(dev);
=20
 	return 0;
@@ -2077,6 +2080,8 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
--=20
2.34.1

Best Regards,
Jake Hamby


Teledyne Confidential; Commercially Sensitive Business Data


