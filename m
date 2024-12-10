Return-Path: <linux-can+bounces-2359-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4119EAB3D
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC75918814C6
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C722616F;
	Tue, 10 Dec 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hainzl.at header.i=dkim@hainzl.at header.b="mkVrivFj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.hainzl.at (mail.hainzl.at [80.120.1.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884211B14FA
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.120.1.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821432; cv=none; b=o8uzcwjf2paDx5aCqZtPha7o9OfdXvhCE4tBw2Xq3K8sb5ZpO4RHR0rXTdba9meNwfwFgJj1p7c3gxDnYuYD5HUd9dZjPTS0jbD8TkRgspFt/iGnl5zVvGVPSzc32GIF21hbmHyAq3bC+4B4Hsp/if3rfQIAd6hoOQIqXkQBKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821432; c=relaxed/simple;
	bh=atPN0j8JOsoXLCbQEKbtniQ9hNeGLpFDAA0uZHhRAc0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AnruGEJSn9Z5e8p+4AyqHT/USQLj5i5G+gF1YdmB1H3sD4Ffemr/N1F/FpB9XBf3Esi1rZ5bBgcCKHVL5mgS20+w855GAjNM8+PoirULnxLxnPj0/3CgL7cBK3KQJd31XcQKVLlD+EkSbaWhNOFNAx7kwRR4iDKB8Qvj7Di5HLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hainzl.at; spf=pass smtp.mailfrom=hainzl.at; dkim=pass (2048-bit key) header.d=hainzl.at header.i=dkim@hainzl.at header.b=mkVrivFj; arc=none smtp.client-ip=80.120.1.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hainzl.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hainzl.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=hainzl.at; i=dkim@hainzl.at; q=dns/txt;
  s=his-dkim-selector; t=1733821430; x=1765357430;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=atPN0j8JOsoXLCbQEKbtniQ9hNeGLpFDAA0uZHhRAc0=;
  b=mkVrivFjrVyUZ20iLlFNnovyk2xDRrRrWOVWXV1Tn69sjYL+S7c6aUyu
   gKXJbv/+oJh9If0i+o6YBG2q0svy1FFWbNP6plM/qvBUIPbgOfEdXXrTU
   Y25h/TDPqRbQ7Z2sAAU1hfE9WrVhKaobshDNQqTbaKFQIL90zWJl0NtdM
   Xlb6lWy+bBU9vJnBD2eAtFNdHe6sdzmFqRchFeveE2J/yjTh+1oGul+Gp
   KiUiF0/XKV1inB28AzuWESi1EahOYYtCZAWMp6H1xKiK+bCUIK3AjKXpM
   d84FuuPKmq25aFNjD0kEeaIVNppfnrLkYRaSLhotIABPaGOtoXH3/5C+o
   Q==;
X-CSE-ConnectionGUID: bFJ6hLrZR6ahNuWElsMe+Q==
X-CSE-MsgGUID: f9FXKvFvRQyAOeoQLWXPmA==
X-ESA-Internal_Domain: true
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2ERBgASA1hn/48AEKxagQmBUwKDJAGCG6hBjAGBfg8BA?=
 =?us-ascii?q?QEBAQEBAQEIAUQEAQGPdCc1CA4BAQEEAQEBAQECBQEBAQEBAQEBAQ0BAQYBA?=
 =?us-ascii?q?gEBAQQIAQKBHYU1U0kBEAGCAIUBGAF/JgEEARqFXrALgTSBAeAggUiFAYNNA?=
 =?us-ascii?q?Y0xhH2LBwSCO4ZgnCgsgSEcA1kyAQ8RNRMXCwcFgTk7AyIMNxUcAoEegRwVg?=
 =?us-ascii?q?Q+BA4JJaUs6Ag0CNoIkJFiCTYUXhGmEWIJJXYJ+ghlPHUADCwdmPTcGDhsGA?=
 =?us-ascii?q?gGBNaFNphShbQeCOIFloUwSHBeDcaZgLodkkGkiowY/FYUEAgQCBAUCF4FpA?=
 =?us-ascii?q?YITTYNbURcCD9EMgTQCBwsBAQMJjXCCYC6BHQEB?=
IronPort-PHdr: A9a23:cWXArheHJSojSbPFyEmRIpYOlGM+EtnLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASQG9qEoKse1aKW6/mmBTdYp87Z8TgrS99laVwssY0uhQsuAcqIWwXQDcXBSGgXO
 voHf3Jeu0+BDE5OBczlbEfTqHDhpRQbGxH4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyL
 BKrpgnNq8Uam4RvJ6gsxhfToHZFeetayX52KV+Sgh3w4tu88IN5/ylftf8t69RMXbnmc6g9U
 LdVECkoP2cp6cLkshXOURGB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw6Viys4
 KhyRBL2hykJKiY1/27LhMN+iqJbuw+hqAdkw4HIeoGVNeFxcb3bcNgHWGdORMdRVyhGAoOhc
 4sCCvcKMOhEo4XhoVYFsB2zDhSuCuzy0D9Fnn/407Mn3eQ9Hw/I3w0gEM4Bvnvbt9j1KL4SU
 eKpwKXU0TnPcvVb0ir95ojSdRAhpOmBU6hqcdLN1UYvFAfFhUiOp4zlODOV0/4Cs3OG5OdnS
 +yjkXQpqxtsojex2sgsiY3Ji5kVyl/e9CV5xoc0JdmiREFhfd6pCZ1dvDyVOIVqWM0tWX1ou
 Dokxb0cv562ZCkHxYo7yhPQaPGKcZaE7g/iWeiRITl1gHFodbG/iRiy80Ws1/PwWte13VpWr
 ydLnNfCuH8Q2xHS6cWKReZw8Emn1D2S1A7T8vlJLV02mKbFMZIt3789moAPvUjZAyP7l0v7g
 LeLekgg5OSk8fnrb7Tlq5OGOIJ4kBzyP6Usl8G5HO82KBIBX3KB9uS5zLDj+Er5T6hUgfAui
 anZtYzaJdwcpq6kHw9ZyoYj5Ai7DzehyNkWn3oJIk9Kdh2GkoTkOkvCIPDiAve+hVStkTNry
 +rcMb39GpnNL37Dn6n9fbtl9kJRyhQ/wcpC659VEL0NPOj/VlL+udHWFhM5Nha7w+fjCNVzz
 IMeXmePD7eHPq/Iq1GI/P8vLPeQa48WvDbwMPgl6OTvjX8/mF4debOl0oELaHygBPRpP12ZY
 WbwgtcGCWoKpBYxTPf0h12BSzFTfW2/X7km6TE+E4KmEIHDRo+3jLOd2ye7G4VaZnpaBVCUD
 Xfoa4KEVu8IaCKTJM9hjzMFWaG9RIA70xGjrxH6y7V5IerO4CEYtozs1MJz5+LNkRE+7zt0D
 96S022VSWF7hXsHRyUq06BnvUx91lCD3LBmj/BAD9xc+e1JXAQgO5PEz+x6CsvyVRzOf9uUS
 VuqWNWmDiswTtI3wt4OZ1xxFM++jhzbwiWqAL4Vl7mTCZIs/azT0Wb/KdphxnjAzKUuklwmT
 dFVNWK6nqNx7xHdCZbGnUmBjKaqbaoc0TbV+mma1WSAs1lUUBVoUaXLRX8fZlXZrdD+5k7aV
 7GgEKwpPAQSgfKFf+FQYcbkjlxcbOzqPc/DZW33kGC1T17c3LiXYYnjYU0G1SDGFU4L1QsU+
 CDCfUI6ByG8syfVBTpGC13ieQXv/PN4pXf9SVU7hUnea0xnyqrw8RcTreKTRulV3b8eviol7
 TJuEwDu8cjRDo+4vZ5qf6EUXdM65V5cnTbl8TRnI5GrLKRKhlcfdRZz+UrygUYkQr5cmNQn+
 St5hDF5LriVhQspSg==
IronPort-Data: A9a23:4lQDY6g95W9w5KZVqJ/h0rx6X161ABEKZh0ujC45NGQN5FlHY01je
 htvWjvQaKyON2vzeIx/PYXjpB5XscKHnddjSAtupXw0QSxjpJueD7x1DG+rZn/PcZeTJK5Ex
 5lHO4WbdJxcolv0+0/F3m3J9CEkvU2wbuOhTrOCYGYpHF8MpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8UkHUMja4mtC4gVkPKgT5zcyqlFMZH4hDfDpR5fHatQMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRrj87XnNJFAatmo23hc+JZk
 b2hhrTsIesdBZAgrcxGO/VuO3onYfAZou+vzU+X6qR/x2WeG5flLm4H4EseZeX08c4vaY1CG
 GBxxJngoXlvisrvqI9XRNWAiewpAuu1PKcFiEs+xDH/EMkLRYvmTubzsIowMDcY3qiiHN7+R
 vE0WWMxKhTJYhtdPhEeFPrSns/x2SO5KmMe8BTM+fFfD2v7lWSd1JDRduLPZ9GBRsF9nk+Zo
 HDCuW3lav0fHIXDlGfbryn97gPJtS2qdrIxCpOmzMd7qXqewVU3Ny0uUHLu9JFVjWb7AbqzM
 Xc84CE1oKs77mSwR9zmQhu35nWDu3Y0X9tWDv1/4wiL4rTb7hzfBWUeSDNFLts8u6cLqScC1
 l6SksOwW3pvubyTW3bb/6v8QS6OBBX55FQqPUcsJTbpKfG6yG3vpnojlupeLZM=
IronPort-HdrOrdr: A9a23:D0t1la4/vfx6RETfNwPXwPnXdLJyesId70hD6qkoc202TiXqrb
 HKoB19726NtN9xYgBYpTnuAsm9qB/nmKKdgrNhRotKPjOW21dARbsKheCJ/9SKIULDH5tmtJ
 uIBJIRNDSfNzRHZI3BkW2F+p4bsb66GY6T9IHj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AilJwMmiXKxccOAadjgKpHsYrcTJueFP/knf0OX2?=
 =?us-ascii?q?CV29pbqCqZFuL3a4nqp87?=
X-Talos-MUID: 9a23:wS+mbAlOMIhCler4mNqtdnpsZelYwLqAFno0gLwhts69ERNAAzK02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from hisex16.hainzl.at ([172.16.0.143])
  by spam.hainzl.at with ESMTP; 10 Dec 2024 10:02:39 +0100
Received: from HISEX16.hainzl.at (172.16.0.143) by HISEX16.hainzl.at
 (172.16.0.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 10 Dec
 2024 10:02:37 +0100
Received: from HISEX16.hainzl.at ([172.16.0.143]) by HISEX16.hainzl.at
 ([172.16.0.143]) with mapi id 15.01.2507.044; Tue, 10 Dec 2024 10:02:37 +0100
From: =?iso-8859-1?Q?Pr=FCckl_Thomas?= <T.Prueckl@hainzl.at>
To: "rcsekar@samsung.com" <rcsekar@samsung.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
Subject: net: m_can: missing mutexes in tx_work_queue and isr-handler
Thread-Topic: net: m_can: missing mutexes in tx_work_queue and isr-handler
Thread-Index: AdtK4ec6I9ygDd19TmudazmqfTyZeg==
Date: Tue, 10 Dec 2024 09:02:37 +0000
Message-ID: <f6a9e128fbc04dcebd70e9b254b344e2@hainzl.at>
Accept-Language: de-DE, de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Chandrasekar,

I'm using the m_can driver with the externals TCAN4550-Q1 can controller (S=
PI) on an IMX8MN controller.
After some time the driver stops working.

After reviewing the driver (m_can.c) I noticed that there are not mutex loc=
ks preventing concurrent access of=20
m_can_isr and m_can_tx_work_queue.

After I added mutex_lock in these functions the driver was working fine.

Is the driver really missing the locking or is it done on another level?

Yours sincerely,
Thomas Prueckl

