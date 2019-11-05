Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B166F08A3
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 22:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKEVqn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 16:46:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40173 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKEVqn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 16:46:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so15460100pgt.7
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0Nlv8i9KxqUx516gJa/0IrT3N9CjcEE9qB8w53KyPFA=;
        b=VoTTCFABsHHNVpIt7Q4vOLmizmojqDWHsdMFmtQMbXEUt7ilN8dskcWLzGwTQTZQCj
         +gyMKMwMedH1b/vwEkwJq0C3kq0R/HV3sN1/AvE/h2tUoekrgqCdQicriVwFLHlY4dzN
         RYZdd1RJLmtAzEOzQ+wRYumXOr6LaDMfTar31AKZodnXM+khI7W4hm12mP9R82OEof6S
         h/ZFw7XUslTZG1p0lVqWKbEvfLscUdamzHuaFK378jFOKnqq6aROnafUigpEJBwbDx/v
         fBaYMcNdIwRl79PQRf4i+zKWnVuNK+849+zKCPJym2KJGAqIl/+YKtubVOtUW79n93tj
         n+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0Nlv8i9KxqUx516gJa/0IrT3N9CjcEE9qB8w53KyPFA=;
        b=ujVVfKmwu4p/Arun6A/4RoSpLMhcvtOmH11r+X489DxTqNibO8YY1eTFXYDtFehXL1
         30dDel9UmKBBT5LlSje1p0GR5Pzxxo79BDG9zd2zgweydNlw4h3l7qdE9ogzzRddWZM6
         Adm/4XPdOUdWPr0ooQgnbL/fd86jTGsVDdntkdGJGjtSyHDFwa33+Yl7dWXWB95Bmnhh
         ncF/+H1ZTzE7HlGDaEfPjo8UCFxqhiuhdoXq7l+mZyb5o3aEVyEpGzL4R+H2uZb8j2bl
         LX3nEQjTo6nWz5VIc4EVCbOnTfEt0zGLEEvCibp8UCL7r1q1RWD2Mus0ak2MD4IFaJTP
         EGdQ==
X-Gm-Message-State: APjAAAWTdOItZtN5v+iExfEic5s50m0BCPeHlLVwff2l9Mbug2aZCtKE
        sHqci2Av/AqhcIWS39azP0++xkjqAtdVVvGcaiCK2KaG
X-Google-Smtp-Source: APXvYqw2fI/ct2vKf/55ie07speCNxSa+nZ+kM1VVqmQGIu03MHBeQj9MlmjiW7y65XTqmwejwcBNA/7iWZrr+ANWqU=
X-Received: by 2002:a17:90a:fc85:: with SMTP id ci5mr1629387pjb.17.1572990402524;
 Tue, 05 Nov 2019 13:46:42 -0800 (PST)
MIME-Version: 1.0
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
In-Reply-To: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
From:   jara.beran@gmail.com
Date:   Tue, 5 Nov 2019 22:46:30 +0100
Message-ID: <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
Subject: Fwd: Return value of write() in BUS-OFF state
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello people,

I've been observing that when a CAN controller is in the BUS-OFF
state, write syscall returns success, which seems quite confusing to
me.

So far I've learned this issue is most probably caused by upper (net
and can) layers (so this is not specific for certain controller
driver). When a driver calls can_bus_off, it sets carrier-off and
triggers linkwatch_* actions that deactivate net queues and substitute
a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
function - noop_enqueue - just returns NET_XMIT_CN, which is
transformed by net_xmit_errno macro to zero, that's passed by
net/can/af_can.c:can_send up to a userspace caller of write as
success.

According to description for qdisc return codes in
include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
notification` and further

/* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
 * indicates that the device will soon be dropping packets, or already drops
 * some packets of the same priority; prompting us to send less aggressively. */


Is this behavior appropriate for a node in BUS-OFF state? I'd rather
expect such controller would be always dropping all frames (not just
soon and some) until reset.

In current situation a caller of write gets success even if his frame
is lost for sure. Is there any specific reason for this? Of course he
can be notified by receiving error frame, but why don't just return
error in can_send?

I'm observing this behavior during continuing work on the CTU CAN FD
IP Core project (http://canbus.pages.fel.cvut.cz/) and on D_CAN
controller integrated on Altera SoC. Though I believe it's not
specifically linked to these controllers only.

Best regards

Jaroslav Beran
