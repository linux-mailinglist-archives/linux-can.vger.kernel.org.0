Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1EF98FB
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLSnM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 13:43:12 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:37495 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLSnM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 13:43:12 -0500
Received: by mail-lj1-f171.google.com with SMTP id d5so9488508ljl.4
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2019 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCeD55CFGts5Mzmowru3gp+xqWjur722WVTYZU3yuMo=;
        b=LlXzIVNtYvEYxowIVX5P4Pe4w3dxhKf7vItzM8n3M8YE3mSaqYfNMjxegOnxlXGMYa
         BTf187a+r8FpmBepnvtKEHAcCPYUbi4pVUYR4452s5tEkXMN9wUbg+ODgYEt+fA40Fcj
         u9OfJt7VsajON4SmiDVf/LpJ5qx1LnCPeyPk3OsS8hTUHfqRs4aXNtlp6JgDhqbJ2HXL
         wFLflSOq59hJK3HNNkUn0dIVlgWadgFz1oHdBZi5y8IPd1gASABgPALnXe6yMl8B+A8s
         dMBiDzrdcqlNYFyzsKvkMfGMf53IcHRt4oz4ANSOSm4HyUP+PxV2O+9GFXKgrnv/TJ1n
         GvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCeD55CFGts5Mzmowru3gp+xqWjur722WVTYZU3yuMo=;
        b=T1xcN09xZv8fE3QgxlIIAfuD0hfpP29D80aliip8SSeqPs8dwKAeU7hGyMkDJWVI2l
         hEQnMe+i4TRwMktffGSYJxjGc6Cj178AgDMvD4ceIJaso4sOLZLARz0pUhAyXOUCet1C
         8bd0KTTZZPnUvv5IC0nnuDEi+dbBvWyvrNax9aHACvcUaqh/pr2kEvTrn1pTQ8ILLjcR
         3Q+AYwgEkEe26tsDMInB7zzoGVo2fPihFFLBdid6oExFARnfk9nDmMU2LNXFw9/6UOHL
         LFsbzHxhM5/yd3a/7wezrGy7ZWE4cHmcWEklN43rbI5HUF40DsOLcIPEmR60Ztn1nisq
         iwBA==
X-Gm-Message-State: APjAAAXiRP1dDHRezGjWS2Rf7rPjaN4x10s5u8t5/vUbuPC915UJdYYP
        AQeZxwn2SK+zV44dHMM5gDrglEWRr9P7MLcp5n0=
X-Google-Smtp-Source: APXvYqwjF2vueu5/LT5wqnmcoO1SSMhz4qpnejUZfiTrYdBpczareYkFIfGMAaU269cDTjP50x6SS6d9U/16vTtf/cI=
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr20870212ljm.38.1573584190406;
 Tue, 12 Nov 2019 10:43:10 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de> <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
In-Reply-To: <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Tue, 12 Nov 2019 10:42:58 -0800
Message-ID: <CAEf4M_CR647GpFs67ebZ50WWhWhO_pkWabukbaW8GfOj4s4O3w@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 12:44 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Can you send the output of
>
>     cat /sys/kernel/debug/clk/clk_summary
>
> Once before loading the module and once after loading it.

I moved the target for the mcp2515 clock from 'target-path = "/";' to
'target = <&scm_clocks>;' and 'clk_get_rate(clk) now returns 16MHz:

fragment@4 {
    target = <&scm_clocks>;
    __overlay__ {
        mcp2515_clock: mcp2515_clock {
            compatible = "fixed-clock";
            #clock-cells = <0>;
            clock-frequency = <16000000>;
        };
    };
};

Here is the current overlay:
https://gist.github.com/pdp7/56174646bb9d075b041f24de2bb01973

dmesg shows it is working correctly:
[   60.089957] mcp251x_can_probe: clk_get_rate(clk)=16000000

I guess the issue was I targeting the wrong node for the clock to be
found with clk_get_rate().

Here is the clk_summary with it working correctly:

debian@beaglebone:/opt/source/bb.org-overlays$ cat
/sys/kernel/debug/clk/clk_summary
   clock                         enable_cnt  prepare_cnt        rate
accuracy   phase
----------------------------------------------------------------------------------------
 mcp2515_clock                            1            1    16000000
       0 0


Thanks,
Drew
