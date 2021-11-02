Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F92443137
	for <lists+linux-can@lfdr.de>; Tue,  2 Nov 2021 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhKBPGW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Nov 2021 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhKBPGV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Nov 2021 11:06:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B381C061714
        for <linux-can@vger.kernel.org>; Tue,  2 Nov 2021 08:03:46 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i12so16007238ila.12
        for <linux-can@vger.kernel.org>; Tue, 02 Nov 2021 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=BH+76tZGjxyYDWE6KSTlJIqaYK5R3lpPXsw+rhEyGXQ=;
        b=Tr8lcINOf0ARGKz4E+WugHKedlrcHjva4uYhM6jp8djvXYBWVaYcha4N+blB8f+BWW
         LSpavBt1cdoaP1pA1lQN3XrJHLpkqI+J1dXM54Mu1ADWAO9HU3Tb178gKI4EUbHltNFL
         FDlVtDoj3wgYIDQQ0VSlqeg51Drgsr2ve/u1dvhlX2srOQEHp3l7C2cWTJ3TlazEHHqN
         2vJ1IZOErQc22KXgRECgXETejKh9I5QoMrJMJoNis4pjh95fo9dxOYWPjrqJRujvSDqF
         Oe8ntbcPEgZTKpVxnAam1GMbAQP85ipidvYI1S6f9JquhXtlNbDpTHyMyD2RGvoKNWKD
         Pivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BH+76tZGjxyYDWE6KSTlJIqaYK5R3lpPXsw+rhEyGXQ=;
        b=eqoNIxXEfMwt9e37k3vGTbKkbCPTmZrE8q7HEOP40O9HgUZXqtXsxVNwB+9JpmvWXC
         cbTY/6pQr2NDRsqIdT/HpLnVBQjMjRGaXTbA4y1y/2opTR0/y7gM6DisByyV22TsSWf/
         cc7xmTy55RPBo5GZhvX4Rap4hPd5sw4z/U2cqHDAsJYIAU9l5FWdkMYC1UWljKJUV/q9
         4hqib9HrAIPb+ke3AOTVyZ0fe8C1gy9R6Hy07d4/YH6qNBHKPlXY8HHd8UVM71rlrvuz
         spm0Lwpn+TDkzaJiR1HT7ZfP1UB7UlJ9OTME+gHSZIiuoeYd+8kuFQ5//UizjeWy3BCp
         C/Ew==
X-Gm-Message-State: AOAM530HNqeK2YB9mgh9Ef4W8OfYSzKv68L2mbcOH5FsFC5xoDudVH7i
        xnV9tanXasvNXisxNFekG0Y5s6kTwI83fJFf+15nCH4rRg==
X-Google-Smtp-Source: ABdhPJwWnFPUmyloQNj+uvQoVaMjeEp0mfnmGXz6d0HaTelUP10DZbk61nDDiw78+TqwhcRO9OcXaugCSmTjSJP2Meo=
X-Received: by 2002:a05:6e02:1347:: with SMTP id k7mr24991527ilr.110.1635865425461;
 Tue, 02 Nov 2021 08:03:45 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Date:   Tue, 2 Nov 2021 16:03:33 +0100
Message-ID: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
Subject: sjw in can_calc_bittiming
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi

we recently had a case here where one member of a CAN bus couldn't receive
frames with data content of only zeros:

$ cansend can0 123#0000000000000000

After some investigation we found the root cause to be a slight difference
(about 1%) in actual bitrates of the two members. The one with showed the
RX errors had a sjw value of 1 and a lot of time quanta (40) due to the 40MHz
CAN clock.

This leads to a build up of phase error (as sjw is not able to compensate for
enough of the bitrate difference) which at some point leads to a framing
error due to missing a stuff bit. Playing around with the sample point can
improve or worsen the behavior.

We can fix this quite easily by specifying a higher sjw value.

Question is now:
Wouldn't it make sense to increase sjw in can_calc_bittiming() to something
like 5% of the total time quanta? This may increase the reliability of the CAN
network when there are differences in the bitrates of the single members. Are
there any arguments against such an arbitrary selection of sjw?

If you agree with such a change I can come up with a proper patch. If I wrote
totally nonsense please tell me :-)

Regards

Matthias
