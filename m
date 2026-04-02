Return-Path: <linux-can+bounces-7325-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sICeMC2YzmkBowYAu9opvQ
	(envelope-from <linux-can+bounces-7325-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 18:24:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7938BCF4
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFD99301A2FC
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3FC3AC0FD;
	Thu,  2 Apr 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2PLjmEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7SNjgVJ"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE241C8C
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147051; cv=none; b=XJCygTEUmu5xGHKAeGSpJg1BQ3L1diYqy7JgPAs7KEktvVrA0moWCMaXVoSePs8PLH+8hQUIanYeqgS3sNvdBAzbzyCEjRjeRb+O6doIFjET2fomxmXKLKwMLAXLSswNsRL8C8wil5nQGTAQQ6SmRJErAMilyxXbQ3qrGSy0LHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147051; c=relaxed/simple;
	bh=kqWi3pRgc4vO4uwnXJM8W78F169nimBmRhW9Abe2Y6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMZieizMje0ZRTEkPdAZ5ztDFXKDBflwnkT0oCL1PNKGeiNP/yA7xbAnZX1CYIJPYuWeMlE/mq1ACDAYKuC7tWOz6gW+MYF12Kdgteo2IwckeDeiJSgHs5YRMq8Kue+7ceNpje0VM7meZgd/y3fsQQTv/JcJ0edpl+l8FGPdmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2PLjmEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7SNjgVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775147048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjL3pli5Rw0BhJlkH0o4h2ZLd02iAKXTf2faJWtjLlc=;
	b=M2PLjmEFvgfVIvQn8nVN8HT+NqKbt5AvHiysBFj28exaUzSHs750xg1MLDSfwpeJVsOeOC
	lAhaDTNWZgtxI8nbyjVztdIQh0eTKG19vwuUCUkaBLvi0XwR9SDcMnW4W0jnY1Xf+Hqncy
	1E9IHkg4o1LCcpw0ZRbAek02KwMU3Lg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-1wuczvW5OSyHx9Ii8BSosg-1; Thu, 02 Apr 2026 12:24:07 -0400
X-MC-Unique: 1wuczvW5OSyHx9Ii8BSosg-1
X-Mimecast-MFC-AGG-ID: 1wuczvW5OSyHx9Ii8BSosg_1775147046
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4888b17ffa6so8131915e9.3
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775147046; x=1775751846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjL3pli5Rw0BhJlkH0o4h2ZLd02iAKXTf2faJWtjLlc=;
        b=L7SNjgVJ9Us2K3UqUtTZ38zgAq2V0CqbDlG6pN6l8BYi32ZeQ1GXG/X3DiAgHj9D2t
         wVUVoUGG88Ls11rlozypxSDJXoJT5azA4z6HU1Y13K6yc34i0Av7nLgfhxiBirEMdfV+
         FD+cF84C2iUykZaF0PhfjUw1bMbxUDE98AG1cGmz5N9CnbipPxrpK0ZQhOZa5cZBUWZZ
         ABz/pPumkoWYKEZEUf4lLbYCpC8IsX276RC4asQ47YlPCMs2BAO8wAMXyssNnb9Lpbtv
         f17u2uc8wm9pJyUxSYdfNT84ASt8rRLwcc1rwG9Yr7p9FDCZacz6PyHO7LTj85eQf3IL
         n7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147046; x=1775751846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjL3pli5Rw0BhJlkH0o4h2ZLd02iAKXTf2faJWtjLlc=;
        b=f36XCF738vN9ecfEwBlmSEZQVijEOhRC8FNQR5fS/KuubPGv71P9dBc5qnuhgBkCPw
         ePGWCRwWwfTsUx3EN/A6lZBizm0IMd5HecRU2YmFbphRyT3kgyAL3vMau/b+O4ianliJ
         /rBYsv0yZ6I21AJYRlkdHBZXqe3OBWxPMBAF3riEI54zvUQNmfotQWcAAQNk2aC8Jl4l
         8Agk4bFCWBiZhPKSGyO1C0jEuZueP/TWZX4UI4syJcF70/awaZiMep58OL0xJl0aVVS9
         dd+SZA1LZwx37g0CeKBoFjHAJHa/1q8jRxDKMVJ8ZgxwlOvs3KLvyYfmfLuqsBFvS/2L
         NcCw==
X-Forwarded-Encrypted: i=1; AJvYcCVyFWMIk7Ooy9rxfA7l52uJwTu0GwNFbD870UV1Y2falJnvYXDKx2VmJKmAxSV5Zk4VdwRUfxIP1ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fSi+w4JGOs/G4L2V7Fxnza8m+yYTfeFVbL7Jjy37VnScZsAR
	maFqXXtLIJDlGmvOX6FIcJ3iqTeMLn+gK1Cc9Wr48td8NRZoiJc9r7sd2RweORxDw97NZ9yWdsP
	Jxdt0UcxqUsRD685sHpu6BNBDW7h59xaFfsm6r65FAwS7NnJJj7WxCMGqb7qa9A==
X-Gm-Gg: ATEYQzzVKB7qBixFGvY8+aNgv1y+QkbZ3yabtGgowzpz+7UYYHvoDaGcS/VzEQ2ny65
	2KFa2YcN5Az42wdYs+eFYTrwvaNspe8oDBo/llDSzwC3wJcq/tpxhoMEMu1N+0HXoCEhMNdLmSw
	y7B9qjP4o5zCp/KkpdOmw3pXpwaAJ1Z1cMzfodlqoRE0CXqrfTEU/QmnK/z70eezR4XXz8+Ovmw
	Zrxk6oI71X9F684RzpmUogK7lCBkF8Uy2ytAcELMc7ykPxCo5iZgUIV32O6mJwu2BoKPtmg3BwR
	pz+Sn6erwcG/1ndgcovx6ac8AZOAVm7COtJNUieS9rtWtgSOsEtKSrrHsilkyNPFs2kT10BiGpa
	wxXr1hkeIkkshb6cWMDmf
X-Received: by 2002:a05:600c:45d2:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48883563408mr140342055e9.12.1775147046247;
        Thu, 02 Apr 2026 09:24:06 -0700 (PDT)
X-Received: by 2002:a05:600c:45d2:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48883563408mr140341005e9.12.1775147045519;
        Thu, 02 Apr 2026 09:24:05 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm80303175e9.6.2026.04.02.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:24:04 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:24:03 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Filippo Storniolo <fstornio@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Urs Thuermann <urs.thuermann@volkswagen.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Radu Rendec <rrendec@redhat.com>
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
Message-ID: <ac6YI19sCfSmgvyh@dcaratti.users.ipa.redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
 <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-7325-lists,linux-can=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78F7938BCF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:07:53PM +0200, Oliver Hartkopp wrote:
> Hello Filippo,
> 
> many thanks for your patches.
> 
> I'm not yet convinced we would need this kind of interface as many features
> in ss(8) are only relevant for IP and not really for CAN.
> 
> Btw. having an overview over PIDs and open sockets might be a nice
> informational feature.


hi, 

thanks for reading!
(an unsolicited answer to the above sentence, just because of the
"Suggested-by:" tag in patch 3/3 :) )

Enumerating open sockets with {uid, pid, interface, protocol} looked to me
a good-enough reason for adding support for ss(8): this is done also by
other non-IP socket families, such as AF_XDP [1] and AF_PACKET for the same
purpose. An alternative would be a tool like tcpstates [2], but it needs to
add tracepoints as well; the diag module (at the expense of serializing
'can_create()' with 'proto.release()' with a mutex) looked a cheaper
solution.

[1] speaking of this, I wonder whether we should pack some of the info we
have now in 'rep', e.g. the result of 'getname()', into a dedicated
attribute. That would save from returning zeros for modules that have stub
getname(), like can_bcm. WDYT?
[2] https://github.com/iovisor/bcc/blob/master/tools/tcpstates.py

-- 
davide


