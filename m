Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2CE5F34
	for <lists+linux-can@lfdr.de>; Sat, 26 Oct 2019 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJZT1g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 26 Oct 2019 15:27:36 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38260 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJZT1g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 26 Oct 2019 15:27:36 -0400
Received: by mail-io1-f50.google.com with SMTP id u8so6186479iom.5
        for <linux-can@vger.kernel.org>; Sat, 26 Oct 2019 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suburbanembedded.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=OYZDMz5ZgJoHfvEfxz5+F9hIL9uxpFJNChR1bgrWrf4=;
        b=TkJxD17JwJCaJk1O92kqNrqA37SYwUb6TcSGxz/YgzuzRhSz19EjgHS2qBHOgQU/HP
         utjrAPJrQ2jFzGQF1+0I/Mp3JYA+mTUNOU+LwnOs6hx4m35eBkB5cXPU1NdoPEIjBaKX
         0nQ65nyWFUsfm2RfY48YXt3pGDpm5csKpFbK06y6qV8JctXDW6bnq8vg1vhvKpzJrSO0
         sDWO68LfEE1NiXhx4abrSweBjDEwqWHI5dtbVGEFcAk/kf/Ka3QyTjEUFgIs7IqzY+50
         EwVjRRoQh6Uj6Fn/F4HBZB14lGIj5u0TbSrAdhvXxgorVFwuSGPiaR+MnkNWyK8clINq
         roxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OYZDMz5ZgJoHfvEfxz5+F9hIL9uxpFJNChR1bgrWrf4=;
        b=M4T1R6kWQikPXj4TvqcGlWsvst6Nqt0Qb5v40kH15lO2+EyiLYm9pMA7hrtReLObl9
         dC5ndWc2iZ1a1qvemHRhjXSY3O6MGqONkqVd9I4F0yAs+7Kb5XfL0FVB1QJ5qXFnTR2Q
         CZYmGbQ2+O9/RKXWvXtG0rTmXofE8KeUY2aHyeMcEOEHBqO2PhYRw5l9H7zy/4j4mSWx
         RNX3z70xTreemd5mb7CatAFKMnl6AF+9WLztmTNBP596KfnO5Efiwr91QOE2KqCG9BFC
         6IDS2e9Ri+alUTxmDPoEdHxtQCcZgINXofWK3KECjeVap9neZvN1CzstdO2WpfBdqQwW
         maYw==
X-Gm-Message-State: APjAAAXTdX++C5Ahfk505/+NDxf9eNib1kvwZXkJCdVUZPx+lqMlopYU
        cGKq+EhZmte56rOOlbcmt56GuCxWO0iQKTbbWUJaVqZ1SW7D+g==
X-Google-Smtp-Source: APXvYqyJrwxbWx+Ii/mPl/jgf6tcIBO5J92qYmfc4hIKis/IhfK0qGttCIsRgqqJAHSNxk6SjWCJ0C7ecXlGh0ibNFA=
X-Received: by 2002:a02:9f8b:: with SMTP id a11mr10690715jam.10.1572118055623;
 Sat, 26 Oct 2019 12:27:35 -0700 (PDT)
MIME-Version: 1.0
From:   Jacob Schloss <jacob.schloss@suburbanembedded.com>
Date:   Sat, 26 Oct 2019 12:27:25 -0700
Message-ID: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
Subject: CAN FD support in slcan - protocol extension?
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

We've made a little CAN-USB adapter that is mostly compatible with the
Lawicel AB text mode protocol that is common for serial-to-can
adapters, but with some extensions for CAN FD.

https://github.com/suburbanembedded/hadoucan-fw
https://www.tindie.com/products/suburbanembedded/hadou-can-usb-can-fd-adapter/

User Guide
https://drive.google.com/open?id=1MtYEAVDF2ImoV_6nmfjP3o9sGMMwxck2wRqLRCWhaTU

The device supports CAN FD, and I arbitrarily picked a new ascii
command to support sending and receiving CAN FD packets, but it would
be interesting if we could standardize FD support and add it to slcan.

Right now I'm using 'd' for an FD message with an 11 bit id, 'D' for a
FD message with a 29 bit id, and permitting FD frames to have DLC
codes 9-F. I can change that if needed. BRS is enabled separately via
a config setting.

Does it make sense to try and coordinate an extension to the text mode
protocol? I'd like to be able to send CAN FD frames through
slcand/cansend etc and keep compatibility with any new hardware that
might start coming out.

Thanks,
Jacob Schloss
