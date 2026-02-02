Return-Path: <linux-can+bounces-6455-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNPHGIvyf2nk0gIAu9opvQ
	(envelope-from <linux-can+bounces-6455-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 01:40:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F3C7A47
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 01:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF703003EC7
	for <lists+linux-can@lfdr.de>; Mon,  2 Feb 2026 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50F17B43F;
	Mon,  2 Feb 2026 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h81UwVJ+"
X-Original-To: linux-can@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F8145355;
	Mon,  2 Feb 2026 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769992839; cv=none; b=ZIpllK77Avi6sqODcup6ejb5WcCv2L3Hs3u1rvGobEKka2p94tAYMdIMhGjTifBzNSen2EuHshkX+tyXoS5LhBnqf5Dlz04nvUcBMD/mtjd8N70tQ+7c7gGhjXRtmfERkTgFnbK0GtDb1kTUSUp4FXk177fs87wTmx0F18Xm4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769992839; c=relaxed/simple;
	bh=lTq6Bi97YdfIhHMr6FJWMbNF27KmtyBlc6YBS9F80Tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DCxX7Jwh9OEeG4dcY1cSOXrlY5Lxo6irGylB+gjgIRuFHNl8ZaPN9rz2lyMMcHdt7C5JP/Bkb/55g+uMaTenMhkCWqNhjCIUtwf+txNItiCes/HXGkfvNq+Y6hZJxZJX5eQvqfJ8oT32W6qki/wbCM0OEnW4o+7I9WNeoQiwFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h81UwVJ+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6120dI3H11744962, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769992758; bh=VMe2HVb2nTeSEgFCoXy0W9x3xhhJDTS7o2oYmrQXOuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=h81UwVJ+k+7FzOwbb1S++4ZPqwtDclUa7KFE2RleclqM3QQBLBP07xas07CBjx0Jk
	 y3V2VyqwXFDrUziPPqORooyz28bbpUuBMNGIBdPuRfY/NXwlkGeUsCamG3UCpSfiFe
	 VRopNFU8kn/IGmQF6wSNs/CGQn5VYW3tKOsHJDxB8wZc5qZQYJRIAxNY/zos0qbLrl
	 QQI0udu281+by8laOjKioUpwTVJU5AQFK9/bYvx8O9TlM4ETEiHhY40YwtcBiMJwg9
	 zkXSfO6CZ9KE2iBXi0Y2E3rpfagp1cuY2YXV5K9KGGXyGKseji+02Sj1hg2kBXEusm
	 xT69Jrgn/lu/Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6120dI3H11744962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 08:39:18 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 08:39:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 08:39:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 2 Feb 2026 08:39:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        =?iso-8859-1?Q?Thomas_M=FChlbacher?= <tmuehlbacher@posteo.net>,
        "Oliver
 Hartkopp" <socketcan@hartkopp.net>
Subject: RE: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Thread-Topic: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Thread-Index: AQHckkqsfpeRiUJcFkKMYOi2hJi0wLVuk+wg
Date: Mon, 2 Feb 2026 00:39:18 +0000
Message-ID: <467153b7aef64c25a340104fe9f00f9d@realtek.com>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6455-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B19F3C7A47
X-Rspamd-Action: no action

Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/arcnet/com20020.c                 | 16 ----------
>  drivers/net/can/sja1000/sja1000.c             | 16 ----------
>  drivers/net/ethernet/8390/8390.c              | 14 ---------
>  drivers/net/ethernet/8390/8390p.c             | 11 -------
>  drivers/net/ethernet/mellanox/mlxsw/pci.c     | 12 --------
>  drivers/net/hamradio/hdlcdrv.c                | 20 -------------
>  drivers/net/net_failover.c                    | 13 ---------
>  drivers/net/wireless/ath/ath9k/common.c       | 12 --------
>  .../realtek/rtlwifi/btcoexist/rtl_btc.c       | 13 ---------

For rtlwifi driver:

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



