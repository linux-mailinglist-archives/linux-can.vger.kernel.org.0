Return-Path: <linux-can+bounces-7305-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HkWDsmNy2kuIwYAu9opvQ
	(envelope-from <linux-can+bounces-7305-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 11:03:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3A366A37
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CED613047411
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F237997E;
	Tue, 31 Mar 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZKW5L9ot"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8233E959D;
	Tue, 31 Mar 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947501; cv=none; b=bU1N7IqFWSC1vwNS5ZUVWqguvICV77KWu/jTmC5ztUi8b8yUO99HzRGo1Qqp+H8YDBAefb7dnQHioBGMTXAEdYMyQ3+38jeZ1cBTVLj1ph0oD+fke8PAkVgGI4tj6NuRY5q5ccDdY8Z2UEcTHfGVoU5h9ULaXHS8Losv2igBSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947501; c=relaxed/simple;
	bh=vhEXvE0O/F/RZV/QZcufgKiBOH3p2ou+L827KWRrR60=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=S747zh6tS/fdvVrscYW7DEURfPNZ2YH9Wr69YkW334xRG3nzOVMhHFDn70nWLFcNDt09Ha2cnOG7f0fnioVwjTpisTX1NaHtXCqH1l3ENBp2oXKvSAMcQQE00X/RWsH+h5vAFGNbvTt8bQXsrWyvjnDEyeOcV3hLRNT6ObaMUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZKW5L9ot; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774947481; x=1775552281; i=markus.elfring@web.de;
	bh=vhEXvE0O/F/RZV/QZcufgKiBOH3p2ou+L827KWRrR60=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZKW5L9otcr4wnU6hbyTixE/ClYvo5CeV2B4hB2h3gEUq3YQb6lMFcxQQvvPc1tuA
	 kyFeThPcHULPIocOVf5Rh4l9zfT6nyw1zoIyRVwbPxwiCZrz9AU7SzGD55LfHy54f
	 qtlD/tVkXEZykmvGs9zI0cMxc1qf/ZnfUHdi5/MTh0GN3uhcyYvdJV4i+2pA+wTDE
	 HgVa1p7sLblWU07BHXmdtNvwk+aKxuhM3eTQx+gs6Bvd0FnPRybZVWi/ncTUytZxV
	 7dOvAJXNS+SNTemuj/sKQU01eBZmZY21p4v84oFvspgY4/HeiaNuvDY4SZODyhwor
	 xKuBmkSW1ASuYbTqpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG9DC-1wJdvU0Qqy-00Blxg; Tue, 31
 Mar 2026 10:52:28 +0200
Message-ID: <155d6442-0d5c-41b0-8955-fb3a656b3e43@web.de>
Date: Tue, 31 Mar 2026 10:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Fourier <fourier.thomas@gmail.com>, linux-can@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>
References: <20260330154236.98665-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260330154236.98665-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uBVprllxaEECxDKKI5gUg2yDBCXOK3NqqXs5MKH5+fU9w+BLnFv
 2RNKrwtI4XW1sIv7Rlz0vFjvFlc61+jicI4nUfm52PY0fFAzTAg8Xhwe1gu+fI5t3uhkE38
 AvIlKDn7n8i8BPlaskb3VPb1Tj35vp9CrCXzABVPsm+aUAOzu37milDqng7WMp8D/NfSlSa
 wbOnLH/B9Cl8pQuAOE4bQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GrGnifKVOkw=;U6Qu6LpaZ24fkf+K6BJCPPtcS4A
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7305-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7B3A366A37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The base_addr is mapped in kvaser_pci_init_one() and the pointer is
> copied to priv->reg_base in kvaser_pci_add_chan() with offset
> channel * KVASER_PCI_PORT_BYTES but unmapped without the offset.
>=20
> Cancel the offset before calling pci_iounmap().

Which action would indicate =E2=80=9Ccancelling=E2=80=9D here?


Would it occasionally be preferred to specify selected message recipients
also in the header =E2=80=9CTo=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0-rc6#n231

Regards,
Markus

