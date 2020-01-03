Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC712FF52
	for <lists+linux-can@lfdr.de>; Sat,  4 Jan 2020 00:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgACXyD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Jan 2020 18:54:03 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:32894 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgACXyD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Jan 2020 18:54:03 -0500
Received: by mail-il1-f196.google.com with SMTP id v15so38004023iln.0
        for <linux-can@vger.kernel.org>; Fri, 03 Jan 2020 15:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLv6sevWK4SOmkrjtAjyOZj+Qda5b1Jn7x8aH9qo+K8=;
        b=bEf0tVPbpgF/RGuqlLh5UtD1vhy+eDFlC7KGKLXVS674lc7EH+GBU9tkLbgZVtM/5e
         OpwZx9ICQaWtDoLIaP6Xqy+DUZCF5I7ORFQizQTYTf3a9QGZ9E5PXKW2sVnRrqKfKCkE
         1cw+ailsa9nRMQ3aYNVtYcCitT182A9sXc/lOBy/PkMHLNysPEXxttrKLZE7sypkJqyi
         QTiPR7Dn3M/cqdLUcAucJKrWnYzQaGZ9IKrBAuUjLzd2ZPlS7f/ZzVXeDw8VFMZPf9X/
         QpPObPsFOabJDuk4Yf+OgY7K+47esC9tWV9jlDKMrh8MZZiDsZDcmDBRDbZxL37Qz5uM
         CsEA==
X-Gm-Message-State: APjAAAVeI60uvmr7NBS55mWK7DHDs6dquLG0vIq3H5j2fgQfCsivWdVv
        0jJD9gT9zDmAI94oVeVRi8nrOYk=
X-Google-Smtp-Source: APXvYqwzvIvTSw+08igxW88ZKlnle7Vljynmn+nJqkEK3/37mfoYruGatizwWPUfgkRXthev9vK1Mg==
X-Received: by 2002:a92:1f16:: with SMTP id i22mr79917790ile.206.1578095642552;
        Fri, 03 Jan 2020 15:54:02 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g12sm12418558iom.5.2020.01.03.15.54.01
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:54:01 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 16:53:59 -0700
Date:   Fri, 3 Jan 2020 16:53:59 -0700
From:   Rob Herring <robh@kernel.org>
To:     pisa@cmp.felk.cvut.cz
Cc:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, socketcan@hartkopp.net,
        wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.jerabek01@gmail.com, ondrej.ille@gmail.com,
        jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
Subject: Re: [PATCH v3 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Message-ID: <20200103235359.GA23875@bogus>
References: <cover.1576922226.git.pisa@cmp.felk.cvut.cz>
 <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Dec 21, 2019 at 03:07:31PM +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

Bindings are moving DT schema format now. Not something I'd require on a 
respin I've already reviewed, but OTOH it's been 10 months to respin 
from v2. So:

Reviewed-by: Rob Herring <robh@kernel.org>

If you have a v4, then please convert to a schema.

Rob
