Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8070E7F2E
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2019 05:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfJ2E04 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Oct 2019 00:26:56 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35114 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJ2E0z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Oct 2019 00:26:55 -0400
Received: by mail-io1-f53.google.com with SMTP id h9so13352613ioh.2
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2019 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suburbanembedded.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OgJrEVePuFJkyIltqi3D2uMKbuthA0H+uvvpk+u4Z8=;
        b=V5TAsuN/recnAEbjds/LFj+sj0Y3JyGSJtdU54HYUaxF+Vy5w3dkY+Jdv8gfRzgL/t
         Z1ptTyAOTg8tAKONuhVg6nZYncDqWYwteyiiHvMcDyeMnqo0Z1zopTV8WVwMJhxi1DWO
         rKbzZe5JGS93x7oM3ITmkNrUcwyEFeqF+Zn0/5QBYDO3gPmbwvXE3g/qZiRdgb21N3jt
         13KwLASO4+tzR+iEf26+c29atL+7OTlMhR+GYBOVo/14yhnMnsS0pLKHogZLPf+90GEn
         aZpWhPHeJJbLR8LsvkN/4r2GkhRrFad7ni9LQFAhd7DU9PUFRp/jC5vWyRuVxFc5WeLW
         FeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OgJrEVePuFJkyIltqi3D2uMKbuthA0H+uvvpk+u4Z8=;
        b=ToI0hdknnCeKXy3LJjp6Od9Nn2m/BiZudJCekASSqR6axM1cDLkKMNrpX8zOV22qvq
         Y9PpStiYGvi6lRjWknjroDG4oOhIEXHGC61AJaU7DvBosjnV6PmMBDMag62ofVyRJGXo
         82grOMlSXjd8G4KAFigOqtDun+EwcSXFNkDgKn9vnUhthIScGyzZXwQjs8VBF0bdQg6Q
         NXOrEfRLSyXRuIaa/injjlgSoAHYhSqjHwCLE2tEnlEr8c2JhuHbN92Zqh+AK7JUt+mU
         UlVYyMzqeaPnsiMF5twduBgofyJSMqQIHUzPUaoPZr3aDYE8PoeI9lQfrjHq1IL+aKhl
         ns0g==
X-Gm-Message-State: APjAAAXjZDZVdHk3z12MwIuWczNlm8fVUJjCqhp10RonASNl95s1CovT
        Kak+ESvJgMu30mW2442s716V2qd0uNUfW8CA6DcGK0PsB9svbQ==
X-Google-Smtp-Source: APXvYqxyLr0e7Vc6KVKzp4T9GZ/QYabnM3+7lA2q7+gIyXTDom6Plsao752Uejw9omjLjcD6KRuEsIYNBJOAz7I3RLc=
X-Received: by 2002:a02:a80c:: with SMTP id f12mr352703jaj.19.1572323214835;
 Mon, 28 Oct 2019 21:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
 <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
In-Reply-To: <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
From:   Jacob Schloss <jacob.schloss@suburbanembedded.com>
Date:   Mon, 28 Oct 2019 21:26:43 -0700
Message-ID: <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
Subject: Re: CAN FD support in slcan - protocol extension?
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jeroen,

> Are you aware of https://github.com/candle-usb/candleLight_fw?
> That uses a one on one binary version of the socketcan driver.
>
> That _might_ be straightforward to extend to FD. And that really
> is a might, since I don't know how it is implemented, but I would
> guess it is a flag.

I have used a device that used the candleLight_fw, but our board is
not compatible and we already have our own implementation of the
Lawicel text protocol working. I could add support for another
protocol, it looks like candlelight is dropping a struct defined here
https://github.com/candle-usb/candleLight_fw/blob/master/include/gs_usb.h,
padded out with zeros to fill a max size USB packet. I guess this is
the can/usb/gs_usb.c driver on Linux's side?

I think it would be easier (for me at least) to extend the text mode
protocol used by net/can/slcan.c. It would also keep it possible to
use the device by hand in a pinch. Since I'm high speed USB, the extra
protocol overhead for ascii encoding seems ok.

Hmm. Extending both gs_usb.c and slcan.c for CAN FD might be useful :
). For gs_host_frame, I guess what is needed is making the data field
longer and adding code to decode can_dlc and update appropriately
everywhere? I'm not sure if there is any other packet framing/header
or if it is assumed that a packet starts and finishes within a USB
transaction? A full size CAN FD packet doesn't fit in a single USB FS
packet, so would need a way to split across 2 USB FS packets. It might
force the protocol to look a bit different.

Thanks,
- Jacob
