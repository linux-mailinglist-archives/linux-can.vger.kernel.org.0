Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC531C84A
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBPJpx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 04:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPJpu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 04:45:50 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844EC061574
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 01:45:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id w4so8559545wmi.4
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxSV94Eg2MhfzImxGDGw7sP++fchdZYvR07bPQCjsJI=;
        b=CXgnRq6uxEr9DwZgK2Enxco/EKEcA6HaVoOKIUpRB48lve93SgzM16UCvARaEY7EZW
         koE9kMH71g850McUpJMAy4eAQ7EUAjQ7TiiJtOwxyDTlJY2IMsAw3SpsVbxXdaDiqohN
         6RVD7i761dvqu9rctllmipqckOMkBehJZiBo8TXpK+XTHqKGpHCf/csI6mQqS/h1wT9u
         MG8di43sQJdAoODzISeIsBBPtw+OJYq3YB3NHIZ+cdFzfrepSzOIBtogrM+pJwBVznO4
         0jR59nu8A4J0xM1o1YMeb2oKRGbrrbfwTL8aG9PKGnLTbqbB/X9kK47aSDQDBWP7K0bY
         L3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxSV94Eg2MhfzImxGDGw7sP++fchdZYvR07bPQCjsJI=;
        b=hVATthM5L2BcKAWM7FDYo0HgK79bvarPSLyehWrZirTQEX49/DO5AEI/G42mgRjV1j
         i1rZOQ3mKSli3mtW9uOO/rvW6pjk1laBCPxgKgANrAK0uUhdkfaFc2OYeGCMuYVbqEwR
         sBHLLQ9bO3KpdGXjG8eduYfEpO+SSR6JYgP4mR8Fxc7T+cU6kOEEh5fn5IQOUjtYBT6W
         4FZR0lf42miqM7mUisFAyDVrWq7pRASZFjNyoxEGqEPTUev5QvGFJQjEjiZvCsSvjvxk
         6lA/rHaZRvYleuAWpfVVLuzQkNnz2N9wUMyR59dK29jj2qiPpbxWLP+d6llXnvt4l0eS
         ZgVQ==
X-Gm-Message-State: AOAM530v4bEA0rSRL7KRcDxVXpN5bYOxl2KgPU7DXdBOY+xjDiOP1je2
        8z2SOa899Id/v8+HekBtRI4/iKS8p49vCKnmEvM4Eg==
X-Google-Smtp-Source: ABdhPJyUKWdTtG9LVIo0iY5CWh/MS1BlIY4SpZ+Bw160+sUpDvKCjuC7BU4p6lm0yxVU4OvE04uVbpCorW9mg7lawMA=
X-Received: by 2002:a1c:356:: with SMTP id 83mr2624877wmd.31.1613468705104;
 Tue, 16 Feb 2021 01:45:05 -0800 (PST)
MIME-Version: 1.0
References: <602651f9.1c69fb81.302a5.647d@mx.google.com> <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com> <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
In-Reply-To: <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
Date:   Tue, 16 Feb 2021 09:44:54 +0000
Message-ID: <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Your mram-cfg looks broken, You don't have any TX Event FIFO entries. Please use
> this one:
>
> bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;

Okay, thanks for the tip, I usually don't make use of the TX event
feature! This hasn't fixed the TX behaviour, though. I've verified
that the frame is loaded into MRAM and requested for TX correctly, but
the transceiver does this...

1. sends start-of-frame, then 5 bits of ID correctly, at the correct bitrate
2. bus then seems to be stuck dominant for 6 bits instead of
transmitting further ID bits
3. bus lines drift back recessive (not a clean edge) over the duration
of 12 bits
4. process repeats

Steps 2-3 constitute an error frame, if my understanding is correct.
Presently the TCAN4550 is not connected to any other CAN nodes; I
would therefore expect the transmit to at least continue to the ACK
field.


--
Regards,

Torin Cooper-Bennun
www.maxiluxsystems.com | Software Engineer
