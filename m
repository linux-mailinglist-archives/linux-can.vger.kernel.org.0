Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACDF9B6F
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLVD2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 16:03:28 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42028 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLVD2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 16:03:28 -0500
Received: by mail-lj1-f179.google.com with SMTP id n5so19420046ljc.9
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2019 13:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6zfkwr07eMlIlRcZ+O526+z5OrZcgLKy8JsMbkM/gs=;
        b=qCFSNxmBxfLrZXuMY8t4cyZ5TmNJklNYfs25+evmDxs/kCKZCoqydj6ZquB2iiy0Rk
         ErCcOu/C9pDbYLkuWhJpjGalzmrmsr/5zNljAYNaLiNKwu/qkFYMZEL/Sip7CVj4Chx/
         KEj8TCQa4fLgUgEC+QpM61iu1l1TPvi633QJw51sMkuLVNDJHuYDfXTw8asahNMr/JNR
         OG/6HrVkvDgW78ObtIbWeXu/Eg9ztAMPoiyy8ZkA+sGwPEbSGptLWYWjpwc6qXLZtOV5
         OumZE3GygNKIDYR7D3oQEAP/9waPjNB6Ex0HrDUAJfVBQxc1u+lSEKDGpz/uj/AV8keZ
         658g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6zfkwr07eMlIlRcZ+O526+z5OrZcgLKy8JsMbkM/gs=;
        b=h3j4tEMfjXOr8kC1jvQ89c2gKqrHu7gYta99ZQRxBnAmCgezF4L9q94HCQUiFxAYod
         TdzFZXXZr1Z+Tok+s6G3Uud0RIcQstdSdJrx5ay2EAM3WI4xWi24/QpZwdJgy30wlpBP
         MBh4XqNaWGZksDTCjeey7XaZeIEALijdT1DSOfeJn/ybfnwWiGCG3YGPTGiKnGKDRYwS
         Wudrtp2HVVfOABJAQm6Hjqb4DvyTzK1ZaqWFYjmYae1IekhfYNT4dOhwSwD2XEkWD/+B
         feAqmgBrnwyNh/DtQ31thSoydtFhUfMPr4e2hbSRpp+FrT/2qU08w3cPI/MH8R+fwLcs
         vzTw==
X-Gm-Message-State: APjAAAV5gFm5y6KU5i6LtH5UlyVIZRwUgBAat0KvqhmOXFYpnL+DiRDH
        gyUdOCRNGuM2/gw3CjU9CpjlnbKPFgPzuqVe2kqmlw==
X-Google-Smtp-Source: APXvYqzNdm1ATsHZdQBJWd+yKT2+73mzNnsVTQLRVkddu0Xv7gBLuK1Nv2RdFAgakt/Vv0Ymyc3QrHl4H0reZc5QxpA=
X-Received: by 2002:a05:651c:8d:: with SMTP id 13mr21527568ljq.216.1573592605987;
 Tue, 12 Nov 2019 13:03:25 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de> <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de> <CAEf4M_CR647GpFs67ebZ50WWhWhO_pkWabukbaW8GfOj4s4O3w@mail.gmail.com>
 <a2a012ad-6b3a-cf37-c79c-c3c473a975b5@pengutronix.de>
In-Reply-To: <a2a012ad-6b3a-cf37-c79c-c3c473a975b5@pengutronix.de>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Tue, 12 Nov 2019 13:03:13 -0800
Message-ID: <CAEf4M_BfHs043wd5m=BxjPXXROWKXXZhyvuaEe53EuaxOXzOew@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 12:15 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > Here is the clk_summary with it working correctly:
> >
> > debian@beaglebone:/opt/source/bb.org-overlays$ cat
> > /sys/kernel/debug/clk/clk_summary
> >    clock                         enable_cnt  prepare_cnt        rate
> > accuracy   phase
> > ----------------------------------------------------------------------------------------
> >  mcp2515_clock                            1            1    16000000
> >        0 0
>
> This is after module loading?

Yes, is after the module loaded.   The DT overlay for the MCP2515 is
loaded by u-boot so Linux gets a complete dtb and loads the mcp251x
driver during boot.

thanks,
drew
