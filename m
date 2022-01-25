Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0116E49AC61
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 07:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiAYG0o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jan 2022 01:26:44 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41913 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S250130AbiAYEO7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jan 2022 23:14:59 -0500
Received: by mail-oi1-f172.google.com with SMTP id q186so28882064oih.8;
        Mon, 24 Jan 2022 20:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bhGT/8JbyJ4yNaXDAh6w/GZ+3o/AFxG25Zw4bunq3is=;
        b=3xABq1TrQa/sryBzj3FyvgudnLlhIxxgfDc0ap4Yw0KMpedkjCjPyrF0mG8I7IfE9c
         K4j2Fxe2sJwdDbt2BRMg4//dM8XoZ1oYRLLLLeIdHr9sc7rRZY0Yqf0CEm8nmBYIc323
         3c5yEe9Wnu2evE+geuwcX6Cd4aWZB9DgHsd50G9TZTAzO+dMl5Cj1QercVWneo+eb/dx
         sA75IhnMixqOuNIJqWWmwCUmbyibt5Rlv3jO4E2SsNXAjRw4H5gywOk/V3sXC1rUGXFa
         EUyU5OV0KtjAEuZ6oirSt9cfjuKdQ0ZEjOtvjtMaW200JDsdxK8B84orAzGecHmcz+4b
         rbvg==
X-Gm-Message-State: AOAM533GxQI6ogEWndIWEVuD/xWIB0F8JDbE+iBqQHZ8/2Sc4SolvWVl
        45ZqIq54ga2ftM55GhNxZw==
X-Google-Smtp-Source: ABdhPJzDG3/XgC2k3xjHyRL5GDrj6sKKbwNOIh4C11g1YoKEBvvR07ScOttJBHCvH2aWkmz67GvEiw==
X-Received: by 2002:a05:6808:6d1:: with SMTP id m17mr4077858oih.139.1643084093068;
        Mon, 24 Jan 2022 20:14:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bk23sm6967904oib.23.2022.01.24.20.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 20:14:52 -0800 (PST)
Received: (nullmailer pid 1221465 invoked by uid 1000);
        Tue, 25 Jan 2022 04:14:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, lrich Hecht <uli+renesas@fpond.eu>
In-Reply-To: <20220124220653.3477172-5-mkl@pengutronix.de>
References: <20220124220653.3477172-1-mkl@pengutronix.de> <20220124220653.3477172-5-mkl@pengutronix.de>
Subject: Re: [PATCH net-next 4/4] dt-binding: can: rcar-can: include common CAN controller bindings
Date:   Mon, 24 Jan 2022 22:14:51 -0600
Message-Id: <1643084091.565337.1221464.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 24 Jan 2022 23:06:53 +0100, Marc Kleine-Budde wrote:
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the rcar-can
> binding.
> 
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: lrich Hecht <uli+renesas@fpond.eu>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-can.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml:102:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/net/can/renesas,rcar-can.example.dts'
Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml: found duplicate key "allOf" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/net/can/renesas,rcar-can.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 661, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 131, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 674, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 445, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 263, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 294, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 4, column 1
found duplicate key "allOf" with value "[]" (original value: "[]")
  in "<unicode string>", line 102, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys


During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 70, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
    print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
AttributeError: 'DuplicateKeyError' object has no attribute 'path'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml: ignoring, error parsing file
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1583769

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

