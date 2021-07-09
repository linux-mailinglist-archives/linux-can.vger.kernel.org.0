Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D763C2338
	for <lists+linux-can@lfdr.de>; Fri,  9 Jul 2021 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhGIMDu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Jul 2021 08:03:50 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41836 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGIMDu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jul 2021 08:03:50 -0400
Received: by mail-lj1-f174.google.com with SMTP id e20so7633492ljn.8
        for <linux-can@vger.kernel.org>; Fri, 09 Jul 2021 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HusOlC1LqIyNcnvKIeT5DptZiSTaOgmOzA9QGV1cZwE=;
        b=bUJTX6ydvme/157xwotWvt2ZCl26EYerxL49a7yGmPl8ETIV0Er8FBJDyAcpnJb5ag
         rnnlPfiJnbZd7Z9binMquMbII7ARv+0puIYxz4TnvKOOqGEdpaeOmmkv3QBC621tQWFe
         d7aTmWFtWhQPEghsD8xaHCeLv+4Sy4T2XqPmAY2wQMi85OHVRYXPPKCvfcCxu9Cq5lKF
         UzFgrAAs18opG7aVAbO5+BFy1MlYsWYxz3FK1xrHRvXMwwrUCvCc3BzvwhmoQUAEi0se
         Dfp28U7KaPG+xH+PqKl72nhboseREoq5WrhzPJOVQLrDlgtsAFqQAOUxlvtwnxnBCNIZ
         gnqg==
X-Gm-Message-State: AOAM531Ic5SQYUwSzyVt7RY/ENznG4n0TkmrStDBsLxnpKGdz71oQ67C
        rlh9F/7OMus1aPfRY9kpoe3VaRYmKlVhZW7rsjo=
X-Google-Smtp-Source: ABdhPJzfFguJhIlMxukdTlDvAcpghtvQPGMHkS3hZwBBSDo2mviPeYviB+3S9JFmvp0szyxXIcuPREs4RbXXz3fZcHs=
X-Received: by 2002:a2e:5c41:: with SMTP id q62mr28521033ljb.254.1625832065017;
 Fri, 09 Jul 2021 05:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
In-Reply-To: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 9 Jul 2021 14:00:54 +0200
Message-ID: <CAMZ6RqLWLPtviMJHOXQJEc430cUPnZeP3N8BdvnV6_dLHYFTpg@mail.gmail.com>
Subject: Re: ip link valid options checking
To:     Joshua Quesenberry <engnfrc@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 7 Jul 2021 at 19:45, Joshua Quesenberry <engnfrc@gmail.com> wrote:
> Good Afternoon,
>
> Do any of you know a way to check what options are valid when setting up a
> CAN device with the ip link commands, either from bash or through C++? I'm
> working on a piece of code that will get used on systems with varying CAN
> drivers and for instance one of them doesn't support CAN-FD, so how would I
> be able to know that setting the fd flag or dbitrate value would fail before
> calling the setup command and seeing it fail?

I would suggest to use:
| ip --details link show can0

You can then parse the results to check if the data bitrate
information is present. If so, it means that FD is supported.
Also, the output might be easier to parse if formatted in json:
| ip --details --json --pretty link show can0

Alternatively, instead of using the command line, you might
prefer to directly use the kernel netlink interface to directly
retrieve the different modes supported by the controller.
You can refer to iproute2 source code for the how-to:
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/ip/iplink_can.c#n282


Yours sincerely,
Vincent
