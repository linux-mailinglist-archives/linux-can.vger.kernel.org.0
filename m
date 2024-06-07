Return-Path: <linux-can+bounces-711-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD28FFEDC
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C28D28DB2D
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B215B968;
	Fri,  7 Jun 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/idddom"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FD15B566
	for <linux-can@vger.kernel.org>; Fri,  7 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751354; cv=none; b=YX3TTwklz58q5o50us0uolCJa37tj3qP1flgfbeO78Q7uK0mSoQbY9HTMfaGOXdmBmB6dRHGygrkXCL8UN/ULgfycYAP/ibvEXkYo4TkEJWSmBv13wZdF/89mgn24VM7tEjDE0/d8Z4TY8SAk/5HonpyyvoGyBYwArg5zzwIaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751354; c=relaxed/simple;
	bh=2g085Qv2sZ+lzpHJ6d/morSwEobDi+HUPO3OoA/Wcfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF51/7KkAo1ri7/b83426z8uluiStE7EEZvPNsU/7yHLM92L+7gMqWYOHT+tyNFxONAJTpU1oSnCO8p83Q6JV0fxNmNInjEDIITvh3Ay5EsY+v3EeACLem5y3UOY3fvlL/rUIw/S9hsk6A0+Td79jHDOGSlWxaOhs0BZTIHgULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/idddom; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
	b=B/idddomBZqIaFPrfi4IYjGU9TA35hrvRBBNa0C+c8kbggb2uRUBdhfVp5SjreAbDifODS
	ICNnYnXtuLz4MiZT9NF26tuWyXxtrDIrNddBLLKwLM5a605iKTRhOttZZ8XpzPLhoLkYq9
	vGKYfHRC7ksSn2L8xL9/Dc7s6IIaEUU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-V3NXgDijNL2g7hwUMJskxA-1; Fri, 07 Jun 2024 05:09:07 -0400
X-MC-Unique: V3NXgDijNL2g7hwUMJskxA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68e0faf1f6so113610766b.3
        for <linux-can@vger.kernel.org>; Fri, 07 Jun 2024 02:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751346; x=1718356146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
        b=Tqm6GNw8L1gw0qFjqj+aT2lfKFCTIz9ikgd/z4y27g2zUchFknsiP8fBl1+bk7gKev
         iOvK0JZDg6nMPhTlEJ//4FSnrs9BCjknK+FSyeJ+s5ZH38Fw+JLKknY3Ypq1/AISgVAf
         +J1kqFBbTTG8bDp0I1wqZzA2Zg/X7ZPn4Uw6Ig7P8tKFHQbx6NXHW3V9ZhToykfVmnpX
         IdPrPGwjOvHLeGjeSJN8OLIci/NqfzoQEEfGOTA5Gh1fID6aUSVqU5POBEJh6pSr6PQK
         aNfl/UIMssMHGqUmbZLo/3BMc6CMOEUm8vw8uOXdvk3Ryro7ExHkyt4EOEVhiIB+nc5r
         KedQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkT8jRfa7m3q3wyY/bI8Ntw0T6wB7vijFxHarKPNoNzM+9Im7md4KPfQ0OHbTBptbJuPApBQe6DmRWunLoYOFkdysza9PwAWqt
X-Gm-Message-State: AOJu0YyjoQm3HDr+EF7thm1IClYL9aWlGekAH80WN8dc8jwNljfzYKyC
	EeSSX0sMIGygT7TBm0yitlvqaBcPx2DyQq4SbGiNDa60yOeupjyIlYeWlYIO1VT26DWFfsTpLKY
	Vp7V/U6qMoPVlseoFR44qcraarehv+QZDBFlCMzzMSA9S0kMRJRz7JWDy1Q==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139567766b.7.1717751345967;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeH+nc8VxKm7H4zo7Jyw3/GG2IBw4hOvl0fOyKmEAvw8ocTKoS9aGEe5N4RDOTTILMmK/Vfg==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139565566b.7.1717751345434;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581f42sm213657566b.1.2024.06.07.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:09:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
Message-ID: <20240607050716-mutt-send-email-mst@kernel.org>
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>

On Thu, Jun 06, 2024 at 04:12:22PM +0200, Harald Mommer wrote:
> Add link to the CAN specification in the ISO shop.
> 
>   ISO 11898-1:2015
>   Road vehicles
>   Controller area network (CAN)
>   Part 1: Data link layer and physical signalling
> 
> The specification is not freely obtainable there.

This message really should not have been posted to any
of the lists that you copied.


> ---
>  introduction.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 8bcef03..72573d6 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>      TRANSMISSION CONTROL PROTOCOL
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
> +	\newline\url{https://www.iso.org/standard/63648.html}\\
>  \end{longtable}
>  
>  \section{Non-Normative References}
> -- 
> 2.34.1
> 


